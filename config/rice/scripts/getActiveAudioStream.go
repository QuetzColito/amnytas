package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"unicode/utf8"
)

// ----------------------- //
// Active Window Detection //
// ----------------------- //

type activeWindow struct {
	Pid         int    `json:"pid"`
	WindowClass string `json:"class"`
	WindowTitle string `json:"title"`
}

func getActiveWindowInfo() (int, string, string, bool) {
	cmd := exec.Command("hyprctl", "activewindow", "-j")
	cmd.Stderr = os.Stderr
	hyprOutput, err := cmd.Output()
	if err != nil {
		fmt.Print("hyprctl failed")
		return 0, "", "", false
	}

	var window activeWindow
	if err := json.Unmarshal(hyprOutput, &window); err != nil {
		fmt.Print(err.Error())
		fmt.Print("Unmarshaling hyprctl data failed")
		return 0, "", "", false
	}
	return window.Pid, window.WindowClass, window.WindowTitle, true
}

// ---------------------- //
// Audio Stream Detection //
// ---------------------- //

type pwObjectID int64
type pwObjectType string

const (
	pwInterfaceDevice pwObjectType = "PipeWire:Interface:Device"
	pwInterfaceNode   pwObjectType = "PipeWire:Interface:Node"
	pwInterfacePort   pwObjectType = "PipeWire:Interface:Port"
	pwInterfaceLink   pwObjectType = "PipeWire:Interface:Link"
)

type pwObject struct {
	ID   pwObjectID   `json:"id"`
	Type pwObjectType `json:"type"`
	Info struct {
		Props pwInfoProps `json:"props"`
	} `json:"info"`
}

type pwInfoProps struct {
	MediaClass string `json:"media.class,omitempty"`
	MediaName  string `json:"media.name,omitempty"`
	Pid        int    `json:"application.process.id,omitempty"`
	Name       string `json:"application.name,omitempty"`
}

const (
	pwAudioDevice        string = "Audio/Device"
	pwAudioSink          string = "Audio/Sink"
	pwAudioSource        string = "Audio/Source"
	pwAudioSourceVirtual string = "Audio/Source/Virtual"
	pwStreamOutputAudio  string = "Stream/Output/Audio"
)

func getAudioStreams() ([]pwObject, bool) {
	cmd := exec.Command("pw-dump")
	cmd.Stderr = os.Stderr

	dumpOutput, err := cmd.Output()
	if err != nil {
		fmt.Print("pw-dump failed")
		return nil, false
	}

	var dump []pwObject
	if err := json.Unmarshal(dumpOutput, &dump); err != nil {
		fmt.Print("Unmarshaling pw-dump data failed")
		return nil, false
	}

	streams := make([]pwObject, 0, 10)
	for i := 0; i < len(dump); i++ {
		if dump[i].Type == pwInterfaceNode {
			props := dump[i].Info.Props
			if props.MediaClass == pwStreamOutputAudio {
				streams = append(streams, dump[i])
			}
		}
	}
	return streams, true
}

// ----------- //
// Process Map //
// ----------- //

func getPsMap() (map[int]int, bool) {
	cmd := exec.Command("ps", "-eo", "ppid,pid")
	cmd.Stderr = os.Stderr

	psOutput, err := cmd.Output()
	if err != nil {
		fmt.Print("ps call failed")
		return nil, false
	}

	psMap := make(map[int]int)

	for relation := range strings.Lines(string(psOutput)) {
		cols := strings.Fields(relation)
		if len(cols) > 1 {
			parent, _ := strconv.Atoi(cols[0])
			child, _ := strconv.Atoi(cols[1])
			psMap[child] = parent
		}
	}
	return psMap, true
}

// ----------- //
// Main Method //
// ----------- //

func main() {
	windowPid, windowClass, windowTitle, ok := getActiveWindowInfo()
	if !ok {
		return
	}

	streams, ok := getAudioStreams()
	if !ok {
		return
	}

	// Return early if Waydroid
	if strings.HasPrefix(windowClass, "waydroid.") {
		for _, stream := range streams {
			if stream.Info.Props.Name == "Waydroid" {
				fmt.Print(stream.ID)
				return
			}
		}
		return
	}

	psMap, ok := getPsMap()
	if !ok {
		return
	}

	childMap := make(map[int][]pwObject)
	for _, stream := range streams {
		for currentId := stream.Info.Props.Pid; currentId > 0; currentId = psMap[currentId] {
			if children, ok := childMap[currentId]; ok {
				childMap[currentId] = append(children, stream)
			} else {
				childMap[currentId] = []pwObject{stream}
			}
		}
	}

	for currentId := windowPid; currentId > 0; currentId = psMap[currentId] {
		if children, ok := childMap[currentId]; ok {
			fmt.Print(findBestMatch(children, windowTitle))
			return
		}
	}
}

// -------------------- //
// Levenshtein Distance //
// -------------------- //

func findBestMatch(streams []pwObject, title string) pwObjectID {
	best := streams[0]
	bestDistance := ComputeDistance(streams[0].Info.Props.MediaName, title)
	for _, stream := range streams {
		newDistance := ComputeDistance(stream.Info.Props.MediaName, title)
		if newDistance < bestDistance {
			bestDistance = newDistance
			best = stream
		}
	}
	return best.ID
}

// levenshtein distance below, taken from https://github.com/agnivade/levenshtein

// minLengthThreshold is the length of the string beyond which
// an allocation will be made. Strings smaller than this will be
// zero alloc.
const minLengthThreshold = 32

// ComputeDistance computes the levenshtein distance between the two
// strings passed as an argument. The return value is the levenshtein distance
//
// Works on runes (Unicode code points) but does not normalize
// the input strings. See https://blog.golang.org/normalization
// and the golang.org/x/text/unicode/norm package.
func ComputeDistance(a, b string) int {
	if len(a) == 0 {
		return utf8.RuneCountInString(b)
	}

	if len(b) == 0 {
		return utf8.RuneCountInString(a)
	}

	if a == b {
		return 0
	}

	// We need to convert to []rune if the strings are non-ASCII.
	// This could be avoided by using utf8.RuneCountInString
	// and then doing some juggling with rune indices,
	// but leads to far more bounds checks. It is a reasonable trade-off.
	s1 := []rune(a)
	s2 := []rune(b)

	// swap to save some memory O(min(a,b)) instead of O(a)
	if len(s1) > len(s2) {
		s1, s2 = s2, s1
	}

	// remove trailing identical runes.
	s1, s2 = trimLongestCommonSuffix(s1, s2)

	// Remove leading identical runes.
	s1, s2 = trimLongestCommonPrefix(s1, s2)

	lenS1 := len(s1)
	lenS2 := len(s2)

	// Init the row.
	var x []uint16
	if lenS1+1 > minLengthThreshold {
		x = make([]uint16, lenS1+1)
	} else {
		// We make a small optimization here for small strings.
		// Because a slice of constant length is effectively an array,
		// it does not allocate. So we can re-slice it to the right length
		// as long as it is below a desired threshold.
		x = make([]uint16, minLengthThreshold)
		x = x[:lenS1+1]
	}

	// we start from 1 because index 0 is already 0.
	for i := 1; i < len(x); i++ {
		x[i] = uint16(i)
	}

	// hoist bounds checks out of the loops
	_ = x[lenS1]
	y := x[1:]
	y = y[:lenS1]
	// fill in the rest
	for i := range lenS2 {
		prev := uint16(i + 1)
		for j := range lenS1 {
			current := x[j] // match
			if s2[i] != s1[j] {
				current = min(x[j], prev, y[j]) + 1
			}
			x[j] = prev
			prev = current
		}
		x[lenS1] = prev
	}
	return int(x[lenS1])
}

func trimLongestCommonSuffix(a, b []rune) ([]rune, []rune) {
	m := min(len(a), len(b))
	a2 := a[len(a)-m:]
	b2 := b[len(b)-m:]
	i := len(a2)
	b2 = b2[:i] // hoist bounds checks out of the loop
	for ; i > 0 && a2[i-1] == b2[i-1]; i-- {
		// deliberately empty body
	}
	return a[:len(a)-len(a2)+i], b[:len(b)-len(b2)+i]
}

func trimLongestCommonPrefix(a, b []rune) ([]rune, []rune) {
	var i int
	for m := min(len(a), len(b)); i < m && a[i] == b[i]; i++ {
		// deliberately empty body
	}
	return a[i:], b[i:]
}
