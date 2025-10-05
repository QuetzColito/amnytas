import QtQuick
import Quickshell.Services.Mpris
import qs.Theme
import qs.Services

Text {
    property string title: MprisService.p?.trackTitle || "Unknown Title"
    property string artist: MprisService.p?.trackArtist || "Unknown Artist"
    property string loopIndicator: MprisService.p?.loopState == MprisLoopState.Track ? "󰑘 " : MprisService.p?.loopState == MprisLoopState.Playlist ? "󰑖 " : ""
    property string shuffleIndicator: MprisService.p?.shuffle ? " " : ""
    elide: Qt.ElideRight

    text: `${shuffleIndicator} ${loopIndicator} ${title} - ${artist}`
    color: MprisService.p?.isPlaying ? Theme.purple : Theme.orange
    font.pointSize: 11
    visible: MprisService.p?.trackTitle || false
    MouseArea {
        onWheel: e => {
            let vol = MprisService.p?.volume;
            MprisService.p.volume = e.angleDelta.y > 0 ? vol + 0.05 : vol - 0.05;
        }
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: MprisService.p.togglePlaying()
    }
}
