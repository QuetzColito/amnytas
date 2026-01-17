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
        id: left
        anchors.left: parent.left
        anchors.top: parent.top

        DashboardItemWrapping {
            Layout.rowSpan: 5
            Layout.columnSpan: 5
            System.Widget {
                anchors.left: parent.left
                anchors.leftMargin: 5
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
                color: Theme.red
                name: "power"
                clickable.onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
            }
        }
        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.orange
                name: "restart"
                clickable.onClicked: Quickshell.execDetached(["systemctl", "reboot"])
            }
        }
        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.green
                name: "logout"
                clickable.onClicked: Quickshell.execDetached(["sh", "-c", "loginctl terminate-user $USER"])
            }
        }
        DashboardItemWrapping {
            IconButton {
                anchors.centerIn: parent
                size: 50
                color: Theme.yellow
                name: "lock"
                clickable.onClicked: Quickshell.execDetached(["qs", "ipc", "call", "lock", "lock"])
            }
        }
    }

    DashboardGrid {
        id: right
        anchors.right: parent.right
        anchors.top: root.screen.width < root.screen.height ? left.bottom : parent.top
        layoutDirection: Qt.RightToLeft

        DashboardItemWrapping {
            visible: MprisService.p?.trackTitle || false
            Layout.rowSpan: 5
            Layout.columnSpan: 4
            Music.Widget {}
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
    }

    component DashboardGrid: GridLayout {
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        anchors.topMargin: 12 + 30
        columns: 10
        rows: 11
        rowSpacing: 10
        columnSpacing: 10
    }

    component DashboardItemWrapping: Rectangle {
        color: Theme.bg
        Layout.preferredHeight: 80 * Layout.rowSpan + 10 * (Layout.rowSpan - 1)
        Layout.preferredWidth: 80 * Layout.columnSpan + 10 * (Layout.columnSpan - 1)
        Layout.minimumHeight: 80 * Layout.rowSpan + 10 * (Layout.rowSpan - 1)
        Layout.minimumWidth: 80 * Layout.columnSpan + 10 * (Layout.columnSpan - 1)
        Layout.maximumHeight: 80 * Layout.rowSpan + 10 * (Layout.rowSpan - 1)
        Layout.maximumWidth: 80 * Layout.columnSpan + 10 * (Layout.columnSpan - 1)
        Layout.fillWidth: true
        Layout.fillHeight: true
        radius: 7
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
