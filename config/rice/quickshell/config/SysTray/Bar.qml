import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.Theme

RowLayout {
    id: items
    property bool anyOpen: popup.visible
    Repeater {
        model: SystemTray.items

        WrapperMouseArea {
            id: root
            required property SystemTrayItem modelData
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: event => {
                // if (event.button === Qt.LeftButton && !modelData.onlyMenu) {
                //     root.modelData.activate();
                // } else if (modelData.hasMenu) {
                popup.anchor.item = icon;
                popup.opener.menu = modelData.menu;
                popup.visible = true;
            // }
            }
            Layout.fillWidth: true
            implicitHeight: 20
            implicitWidth: 20

            IconImage {
                id: icon
                source: root.modelData.icon
                asynchronous: true
                anchors.fill: parent
            }
        }
    }
    Menu {
        id: popup
    }
    function disable(): void {
        popup.visible = false;
    }
}
