import QtQuick
import Quickshell.Widgets
import qs.Theme
import qs.Components

Item {
    id: root
    required property real battery
    property bool charging: false

    implicitWidth: icon.width + text.width
    implicitHeight: Math.max(icon.height, text.height)

    ColoredIcon {
        id: icon
        name: `battery-${charging ? "c" : Math.floor(battery * 7)}`

        color: battery > .3 ? Theme.cyan : Theme.red
    }

    ThemedText {
        id: text
        anchors.left: icon.right
        anchors.verticalCenter: icon.verticalCenter
        text: Math.round(battery * 100) + "%"

        color: battery > .3 ? Theme.cyan : Theme.red
    }
}
