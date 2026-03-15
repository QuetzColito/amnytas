import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.Theme
import qs.Services
import qs.Components

RowLayout {
    id: root
    visible: MprisService.p?.trackTitle || false
    required property int maxWidth
    ColoredIcon {
        id: shuffle
        size: 20
        name: MprisService.p?.shuffle ? "shuffle " : ""
    }

    ColoredIcon {
        id: repeat
        size: 20
        name: MprisService.p?.loopState == MprisLoopState.Track ? "repeat-once" : MprisService.p?.loopState == MprisLoopState.Playlist ? "repeat" : ""
    }

    ThemedText {
        property string title: MprisService.p?.trackTitle || "Unknown Title"
        property string artist: MprisService.p?.trackArtist || "Unknown Artist"
        Layout.maximumWidth: root.maxWidth - (repeat.name != "" ? repeat.size + 5 : 0) - (shuffle.name != "" ? shuffle.size + 5 : 0)
        elide: Qt.ElideRight

        text: `${title} - ${artist}`
        color: MprisService.p?.isPlaying ? Theme.blue : Theme.fg4
        MouseArea {
            onWheel: e => MprisService.p.volume = MprisService.p?.volume + (e.angleDelta.y > 0 ? +.05 : -.05)
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            onClicked: MprisService.p.togglePlaying()
        }
    }
}
