import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Wayland
import Quickshell.Io
import qs.Shapes

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
        visible: bar.systray.anyOpen
        MouseArea {
            anchors.fill: parent
            onClicked: bar.systray.disable()
            cursorShape: Qt.ForbiddenCursor
        }
        anchors.fill: parent
    }

    Widget {
        id: bar
        closer: closer
        toggleOverlay: root.toggleOverlay
    }

    Corner.BottomLeft {
        y: root.screen.height - 20
    }
    Corner.BottomRight {
        y: root.screen.height - 20
        x: root.screen.width - 20
    }
    Corner.TopLeft {
        y: 30
    }
    Corner.TopRight {
        y: 30
        anchors.right: parent.right
    }

    mask: bar.mask
    IpcHandler {
        target: `"${root.screen.name}"`

        function bar(): void {
            root.visible = !root.visible;
        }
    }

    function toggleOverlay(): void {
        Quickshell.execDetached(["sh", "-c", "qs ipc call dashboard toggle"]);
    }
}
