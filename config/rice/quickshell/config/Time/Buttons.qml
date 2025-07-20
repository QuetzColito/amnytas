import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:Theme"
import "root:Components"

ColumnLayout {
    spacing: 10
    Layout.fillWidth: true
    SysButton {
        text.text: ""
        text.color: Theme.red
    }
    SysButton {
        text.text: "󰜉"
        text.color: Theme.orange
        text.font.pointSize: 40
    }
    SysButton {
        text.text: "󰗽"
        text.color: Theme.green
    }
    SysButton {
        text.text: ""
        text.color: Theme.yellow
    }

    component SysButton: TextButton {
        Layout.fillWidth: true
    }
}
