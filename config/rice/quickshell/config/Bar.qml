import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import "root:Shapes"
import "root:Theme"
import "root:Components"
import "root:Music" as Music
import "root:Audio" as Audio
import "root:Time" as Time
import "root:SysTray" as SysTray
import "root:Widgets"

PanelWindow {
    id: barwindow
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
            onClicked: disableAll()
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
                    onClicked: barwindow.toggleOverlay()
                }
            }
            Workspaces {}
            SysTray.Bar {
                id: systray
            }
        }
        bigItem: System {}
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
                Layout.maximumWidth: screen.width / 2 - volume.width - midarea.width / 2 - 30
                Clickable {
                    acceptedButtons: Qt.RightButton
                    onClicked: rightarea.toggle()
                }
            }
            Audio.Volume {
                id: volume
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

    component Clickable: MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
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
        target: `"${screen.name}"`

        function dashboard(): void {
            toggleOverlay();
        }

        function bar(): void {
            barwindow.visible = !barwindow.visible;
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
