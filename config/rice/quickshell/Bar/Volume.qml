import QtQuick
import qs.Theme
import qs.Services
import qs.Components

ThemedText {
    text: `   ${AudioService.volume}% `
    color: AudioService.muted ? Theme.fg4 : Theme.blue
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: () => AudioService.toggleMute()
        onWheel: e => e.angleDelta.y > 0 ? AudioService.increaseVolume() : AudioService.decreaseVolume()
    }
}
