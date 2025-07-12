import QtQuick
import QtQuick.Layouts
import Quickshell
import "../Theme"

PanelWindow {
    id: root
    color: `#33FF0000`
    property QsMenuOpener menu: null
    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }
    visible: false
    exclusionMode: ExclusionMode.Ignore
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: () => {
            popup.visible = false;
            clicky.visible = false;
        }
    }
    PanelWindow {
        id: show
        anchors {
            top: true
            right: true
        }
        exclusionMode: ExclusionMode.Ignore
        visible: false

        color: Colors.bg

        implicitWidth: entries.width
        implicitHeight: entries.height

        ColumnLayout {
            id: entries
            anchors.margins: 1
            Repeater {
                model: menu.children
                SysTrayMenuItem {}
            }
        }
    }
    function toggle(): void {
        root.visible = !root.visible;
        show.visible = !show.visible;
    }
}
