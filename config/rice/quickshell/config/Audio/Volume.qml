import QtQuick
import Quickshell.Services.Pipewire
import "../Theme"

Text {
    text: `    ${Audio.volume}% `
    color: Audio.muted ? Theme.red : Theme.blue
    font.pointSize: 11
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: () => Audio.toggleMute()
        onWheel: e => e.angleDelta.y > 0 ? Audio.increaseVolume() : Audio.decreaseVolume()
    }
}
