pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../Theme"

RowLayout {
    required property QtObject anchorItem

    Repeater {
        model: SystemTray.items

        MouseArea {
            id: root
            required property SystemTrayItem modelData
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: event => {
                if (event.button === Qt.LeftButton)
                    root.modelData.activate();
                else if (modelData.hasMenu) {
                    menu.menu = root.modelData.menu;
                    popup.menu = menu;
                    popup.toggle();
                }
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

    QsMenuOpener {
        id: menu

        menu: null
    }

    SysTrayMenu {
        id: popup
        menu: menu
    }
}
