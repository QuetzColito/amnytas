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

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: 30
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

    Rectangle {
        id: leftarea
        bottomRightRadius: 10
        color: Theme.bg
        implicitWidth: leftLayout.width + 15
        implicitHeight: Theme.barheight

        RowLayout {
            id: leftLayout
            anchors.centerIn: parent
            Text {
                font.pointSize: 18
                color: Theme.cyan
                text: ""
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
    }
    Corner.TopLeft {
        x: leftarea.width
    }
    Corner.TopRight {
        x: midarea.x - 20
    }

    Rectangle {
        id: midarea
        bottomRightRadius: 10
        bottomLeftRadius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: midLayout.width + 15
        implicitHeight: Theme.barheight
        color: Theme.bg

        Time {
            id: midLayout
            anchors.centerIn: parent
            Clickable {
                onClicked: root.toggleOverlay()
            }
        }
    }
    Corner.TopLeft {
        anchors.left: midarea.right
    }
    Corner.TopRight {
        anchors.right: rightarea.left
    }

    Rectangle {
        id: rightarea
        anchors.right: parent.right
        bottomLeftRadius: 10
        implicitWidth: rightLayout.width + 10
        implicitHeight: Theme.barheight
        color: Theme.bg
        RowLayout {
            id: rightLayout
            anchors.centerIn: parent
            Mpris {
                Layout.maximumWidth: root.width / 2 - volume.width - midarea.width / 2 - 55 - notif.width - (battery.visible ? battery.width : 0)
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
}
