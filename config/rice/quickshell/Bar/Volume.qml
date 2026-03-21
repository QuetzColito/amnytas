import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Services
import qs.Components

ClickableWrapper {
    onClicked: () => AudioService.toggleMute()
    onWheel: e => e.angleDelta.y > 0 ? AudioService.increaseVolume() : AudioService.decreaseVolume()

    RowLayout {
        id: row
        anchors.fill: parent
        ColoredIcon {
            name: AudioService.muted ? "speaker-slash" : AudioService.volume > 50 ? "speaker-2" : AudioService.volume > 0 ? "speaker-1" : "speaker-0"
            size: 20
        }

        ThemedText {
            text: `${AudioService.volume}%`
            color: AudioService.muted ? Theme.fg4 : Theme.blue
        }
    }
}
