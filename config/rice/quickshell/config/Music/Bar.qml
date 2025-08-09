import QtQuick
import Quickshell.Services.Mpris
import qs.Theme

Text {
    property string title: Player.p?.trackTitle || "Unknown Title"
    property string artist: Player.p?.trackArtist || "Unknown Artist"
    property string loopIndicator: Player.p?.loopState == MprisLoopState.Track ? "󰑘 " : Player.p?.loopState == MprisLoopState.Playlist ? "󰑖 " : ""
    property string shuffleIndicator: Player.p?.shuffle ? " " : ""
    elide: Qt.ElideRight

    text: `${shuffleIndicator} ${loopIndicator} ${title} - ${artist}`
    color: Player.p?.isPlaying ? Theme.purple : Theme.orange
    font.pointSize: 11
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: Player.p.togglePlaying()
    }
}
