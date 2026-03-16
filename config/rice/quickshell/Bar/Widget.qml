import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import qs.Theme
import qs.Components
import qs.Services
import qs.Windows
import qs.Bar.SysTray as SysTray

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
        item: root
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
            // Needs to be this way so this gets priority over Workspaces
            Clickable {
                acceptedButtons: Qt.RightButton
                onClicked: root.toggleOverlay()
            }
        }
        KeyboardBarButton {}
        SysTray.Bar {
            id: systray
        }
    }

    ClickableWrapper {
        id: midarea
        anchors.centerIn: parent
        onClicked: root.toggleOverlay()
        Time {
            id: time
            anchors.fill: parent
        }
    }

    RowLayout {
        id: rightarea
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        ClickableWrapper {
            onClicked: root.toggleOverlay()
            Mpris {
                id: mpris
                maxWidth: root.width / 2 - 50 - volume.width - midarea.width / 2 - notif.width - (battery.visible ? battery.width : 0)
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
