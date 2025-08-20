import QtQuick
import qs.Theme
import qs.Services

Text {
    text: `    ${AudioService.volume}% `
    color: AudioService.muted ? Theme.red : Theme.blue
    font.pointSize: 11
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: () => AudioService.toggleMute()
        onWheel: e => e.angleDelta.y > 0 ? AudioService.increaseVolume() : AudioService.decreaseVolume()
    }
}
