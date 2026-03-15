import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Services
import qs.Components

MouseArea {
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight
    RowLayout {
        id: row
        anchors.fill: parent
        ColoredIcon {
            name: AudioService.muted ? "speaker-slash" : AudioService.volume > 66 ? "speaker-2" : AudioService.volume > 33 ? "speaker-1" : "speaker-0"
            size: 20
        }

        ThemedText {
            text: `${AudioService.volume}%`
            color: AudioService.muted ? Theme.fg4 : Theme.blue
        }
    }
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    onClicked: () => AudioService.toggleMute()
    onWheel: e => e.angleDelta.y > 0 ? AudioService.increaseVolume() : AudioService.decreaseVolume()
}
