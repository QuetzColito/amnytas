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

PanelWindow {
    id: root
    property var modelData
    property bool overlayOn: false
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.namespace: "qs-bar"
    anchors {
        top: true
        left: true
        right: true
    }
    color: "transparent"

    implicitHeight: screen.height
    exclusiveZone: 30
    Item {
        id: closer
        visible: systray.anyOpen
        MouseArea {
            anchors.fill: parent
            onClicked: root.disableAll()
        }
        anchors.fill: parent
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
                Layout.maximumWidth: screen.width / 2 - volume.width - midarea.width / 2 - 55 - notif.width - (battery.visible ? battery.width : 0)
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

    Corner.BottomLeft {
        y: root.screen.height - 20
    }
    Corner.BottomRight {
        y: root.screen.height - 20
        x: root.screen.width - 20
    }
    Corner.TopLeft {
        anchors.top: leftarea.bottom
    }
    Corner.TopRight {
        anchors.top: rightarea.bottom
        anchors.right: rightarea.right
    }

    mask: Region {
        item: closer.visible ? closer : rightarea
        Region {
            item: midarea
        }
        Region {
            item: leftarea
        }
    }

    IpcHandler {
        target: `"${root.screen.name}"`

        function bar(): void {
            root.visible = !root.visible;
        }
    }

    function disableAll(): void {
        systray.disable();
    }

    function toggleOverlay(): void {
        Quickshell.execDetached(["sh", "-c", "qs ipc call dashboard toggle"]);
    }
}
