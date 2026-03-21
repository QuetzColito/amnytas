pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Theme
import qs.Bar as Bar
import qs.Widgets.Utils
import qs.Components
import qs.Widgets.System as System
import qs.Widgets.Music as Music
import qs.Services

PanelWindow {
    id: root
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "qs-dashboard"
    screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor?.name) || null
    property bool hasBar: !Hyprland.focusedMonitor?.activeWorkspace.hasFullscreen
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    visible: false
    color: "transparent"

    Item {
        id: closer
        anchors.fill: parent

        Clickable {
            onClicked: {
                if (bar.systray.anyOpen)
                    bar.systray.disable();
                else
                    root.visible = false;
            }
            cursorShape: Qt.ForbiddenCursor
        }
    }

    Bar.Widget {
        id: bar
        visible: !root.hasBar

        closer: closer
        toggleOverlay: () => {}
    }

    DashboardGrid {
        // Both Grids can support 10x10
        id: left
        anchors.left: parent.left
        anchors.top: root.screen.width < root.screen.height ? right.bottom : parent.top

        DashboardItemWrapping {
            Layout.rowSpan: 5
            Layout.columnSpan: 5
            System.HyprInfo {
                anchors.left: parent.left
                anchors.leftMargin: 3
            }
        }

        DashboardItemWrapping {
            Layout.rowSpan: 1
            Layout.columnSpan: 3
            Clock {
                anchors.centerIn: parent
            }
        }

        DashboardItemWrapping {
            Layout.rowSpan: 3
            Layout.columnSpan: 3
            Calendar {
                anchors.centerIn: parent
            }
        }

        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.purple
                name: "power"
                clickable.onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
            }
        }
        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.blue
                name: "arrow-counter-clockwise"
                clickable.onClicked: Quickshell.execDetached(["systemctl", "reboot"])
            }
        }
        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.blue
                name: "sign-out"
                clickable.onClicked: Quickshell.execDetached(["sh", "-c", "loginctl terminate-user $USER"])
            }
        }
        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.cyan
                name: "lock"
                clickable.onClicked: Quickshell.execDetached(["qs", "ipc", "call", "lock", "lock"])
            }
        }
        Padding {
            model: 7
        }
        DashboardItemWrapping {
            Layout.rowSpan: NetworkService.hasWifi ? 5 : 1
            Layout.columnSpan: 5
            System.NetworkTab {
                anchors.left: parent.left
                anchors.leftMargin: 3
            }
        }
        // Padding {
        //     model: 25
        // }
    }

    DashboardGrid {
        id: right
        anchors.right: parent.right
        anchors.top: parent.top
        layoutDirection: Qt.RightToLeft

        DashboardItemWrapping {
            Layout.rowSpan: 5
            Layout.columnSpan: 5
            System.SoundTab {
                anchors.left: parent.left
                anchors.leftMargin: 3
            }
        }
        DashboardItemWrapping {
            Layout.rowSpan: 4
            Layout.columnSpan: 3
            Calculator {
                anchors.fill: parent
                anchors.centerIn: parent
            }
        }

        DashboardItemWrapping {
            Layout.rowSpan: 2
            Layout.columnSpan: 2
            Timer {
                anchors.centerIn: parent
            }
        }

        DashboardItemWrapping {
            Die {
                anchors.centerIn: parent
            }
        }
        Padding {
            model: 5
        }

        DashboardItemWrapping {
            visible: MprisService.p?.trackTitle || false
            Layout.rowSpan: 5
            Layout.columnSpan: 4
            Music.Widget {}
        }
        DashboardItemWrapping {
            Layout.rowSpan: 5
            Layout.columnSpan: 5
            visible: BluetoothService.isPresent
            System.BluetoothTab {
                anchors.left: parent.left
                anchors.leftMargin: 3
            }
        }
        // Padding {
        //     model: 63
        // }
    }

    component DashboardGrid: GridLayout {
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        anchors.topMargin: 12 + 30
        columns: 10
        rows: 11
        rowSpacing: 5
        columnSpacing: 5
    }

    component DashboardItemWrapping: Rectangle {
        color: Theme.bg
        Layout.preferredHeight: 80 * Layout.rowSpan + 5 * (Layout.rowSpan - 1)
        Layout.preferredWidth: 80 * Layout.columnSpan + 5 * (Layout.columnSpan - 1)
        Layout.minimumHeight: 80 * Layout.rowSpan + 5 * (Layout.rowSpan - 1)
        Layout.maximumWidth: 80 * Layout.columnSpan + 5 * (Layout.columnSpan - 1)
        Layout.maximumHeight: 80 * Layout.rowSpan + 5 * (Layout.rowSpan - 1)
        Layout.minimumWidth: 80 * Layout.columnSpan + 5 * (Layout.columnSpan - 1)
        Layout.fillWidth: true
        Layout.fillHeight: true
        border.width: 2
        radius: 3
        border.color: Theme.blue
        Clickable {
            cursorShape: Qt.ArrowCursor
        }
    }

    component Padding: Repeater {
        delegate: Item {
            implicitWidth: 80
            implicitHeight: 80
        }
    }

    IpcHandler {
        id: ipc
        target: "dashboard"
        function toggle(): void {
            const screen = Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor?.name);
            if (!root.visible) {
                root.screen = screen;
                root.visible = true;
            } else if (screen != root.screen) {
                root.screen = screen;
            } else {
                root.visible = false;
            }
        }
    }
}
