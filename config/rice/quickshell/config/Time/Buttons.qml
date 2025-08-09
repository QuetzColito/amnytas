import QtQuick.Layouts
import QtQuick
import Quickshell
import qs.Theme
import qs.Components

ColumnLayout {
    spacing: 10
    Layout.fillWidth: true
    SysButton {
        text.text: ""
        text.color: Theme.red
        onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
    }
    SysButton {
        text.text: "󰜉"
        text.color: Theme.orange
        text.font.pointSize: 40
        onClicked: Quickshell.execDetached(["systemctl", "reboot"])
    }
    SysButton {
        text.text: "󰗽"
        text.color: Theme.green
        onClicked: Quickshell.execDetached(["sh", "-c", "loginctl terminate-user $USER"])
    }
    SysButton {
        text.text: ""
        text.color: Theme.yellow
        onClicked: Quickshell.execDetached(["hyprlock", "--immediate"])
    }

    component SysButton: TextButton {
        Layout.fillWidth: true
    }
}
