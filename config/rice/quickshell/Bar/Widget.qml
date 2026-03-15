import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import qs.Shapes
import qs.Theme
import qs.Components
import qs.Services
import qs.Bar.SysTray as SysTray
import qs.Widgets.System as System
import qs.Widgets.Utils as Utils
import qs.Widgets.Music as Music

Rectangle {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: 30
    color: Theme.bg
    required property var toggleOverlay
    required property Item closer
    property SysTray.Bar systray: systray
    property Region mask: Region {
        item: rightarea
        Region {
            item: midarea
        }
        Region {
            item: leftarea
        }
        Region {
            item: root.closer.visible ? root.closer : midarea
        }
    }

    RowLayout {
        id: leftarea
        anchors.verticalCenter: parent.verticalCenter
        ColoredIcon {
            color: Theme.blue
            size: 18
            name: "nixos"
            Clickable {
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: root.toggleOverlay()
            }
        }
        Item {
            implicitHeight: ws.height
            implicitWidth: ws.width

            Workspaces {
                id: ws
            }
            Clickable {
                acceptedButtons: Qt.RightButton
                onClicked: root.toggleOverlay()
            }
        }
        SysTray.Bar {
            id: systray
        }
    }

    MouseArea {
        id: midarea
        anchors.centerIn: parent
        onClicked: root.toggleOverlay()
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        implicitWidth: time.implicitWidth
        implicitHeight: time.implicitHeight
        Time {
            id: time
            anchors.fill: parent
        }
    }

    RowLayout {
        id: rightarea
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Mpris {
            maxWidth: root.width / 2 - 50 - volume.width - midarea.width / 2 - notif.width - (battery.visible ? battery.width : 0)
            Clickable {
                acceptedButtons: Qt.RightButton
                onClicked: root.toggleOverlay()
            }
        }
        Volume {
            id: volume
        }
        BatteryIcon {
            id: battery
            visible: PowerService.hasBattery
            battery: PowerService.charge
            charging: PowerService.charging
        }
        Notifications {
            id: notif
        }
    }
}
