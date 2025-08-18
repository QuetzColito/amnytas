import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import qs.Shapes
import qs.Theme
import qs.Components
import qs.Music as Music
import qs.Audio as Audio
import qs.Time as Time
import qs.SysTray as SysTray
import qs.Notifications as Notifications
import qs.System as System

PanelWindow {
    id: root
    property var modelData
    property bool overlayOn: false
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
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
        visible: leftarea.isDrawn || midarea.isDrawn || rightarea.isDrawn || systray.anyOpen
        MouseArea {
            anchors.fill: parent
            onClicked: root.disableAll()
        }
        anchors.fill: parent
    }

    Drawer {
        id: leftarea
        hasRightCorners: true
        alignment: Qt.AlignLeft
        smallItem: RowLayout {
            Text {
                font.pointSize: 18
                color: Theme.cyan
                text: ""
                Clickable {
                    acceptedButtons: Qt.RightButton
                    onClicked: leftarea.toggle()
                }
            }
            Workspaces {}
            SysTray.Bar {
                id: systray
            }
        }
        bigItem: System.Tabs {}
    }
    Corner.TopLeft {
        x: leftarea.xr
    }
    Corner.TopRight {
        x: midarea.xl - 20
    }

    Drawer {
        id: midarea
        anchors.horizontalCenter: parent.horizontalCenter
        alignment: Qt.AlignHCenter
        hasRightCorners: true
        hasLeftCorners: true
        smallItem: Time.Bar {
            Clickable {
                onClicked: midarea.toggle()
            }
        }
        bigItem: Time.Widget {}
    }
    Corner.TopLeft {
        x: midarea.xr
        // visible: rightarea.xl - midarea.xr > 40
        radius: Math.min(20, (rightarea.xl - midarea.xr) / 2)
        visible: radius > 0
    }
    Corner.TopRight {
        x: rightarea.xl - radius
        radius: Math.min(20, (rightarea.xl - midarea.xr) / 2)
        visible: radius > 0
    }

    Drawer {
        id: rightarea
        anchors.right: parent.right
        alignment: Qt.AlignRight
        hasLeftCorners: true
        smallItem: RowLayout {
            Music.Bar {
                Layout.maximumWidth: screen.width / 2 - volume.width - midarea.width / 2 - 30 - notif.width
                Clickable {
                    acceptedButtons: Qt.RightButton
                    onClicked: rightarea.toggle()
                }
            }
            Audio.Volume {
                id: volume
            }
            Notifications.Bar {
                id: notif
            }
        }
        bigItem: Music.Widget {}
    }

    Corner.BottomLeft {
        y: screen.height - 20
    }
    Corner.BottomRight {
        y: screen.height - 20
        x: screen.width - 20
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

    function disableAll(): void {
        leftarea.disable();
        midarea.disable();
        rightarea.disable();
        systray.disable();
        if (overlayOn) {
            Hyprland.dispatch(`togglespecialworkspace helper`);
            overlayOn = false;
        }
    }
    IpcHandler {
        target: `"${root.screen.name}"`

        function dashboard(): void {
            root.toggleOverlay();
        }

        function bar(): void {
            root.visible = !root.visible;
        }
    }

    function toggleOverlay(): void {
        if (overlayOn) {
            disableAll();
        } else {
            Hyprland.dispatch(`togglespecialworkspace helper`);
            leftarea.enable();
            midarea.enable();
            rightarea.enable();
            overlayOn = true;
        }
    }
}
