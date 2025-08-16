import QtQuick.Layouts
import QtQuick
import Quickshell
import qs.Theme
import qs.Components

ColumnLayout {
    spacing: 25
    Layout.alignment: Qt.AlignCenter

    SysButton {
        color: Theme.red
        name: "power"
        clickable.onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
    }
    SysButton {
        color: Theme.orange
        name: "restart"
        clickable.onClicked: Quickshell.execDetached(["systemctl", "reboot"])
    }
    SysButton {
        color: Theme.green
        name: "logout"
        clickable.onClicked: Quickshell.execDetached(["sh", "-c", "loginctl terminate-user $USER"])
    }
    SysButton {
        color: Theme.yellow
        name: "lock"
        clickable.onClicked: Quickshell.execDetached(["hyprlock", "--immediate"])
    }
    component SysButton: IconButton {
        size: 50
    }
}
