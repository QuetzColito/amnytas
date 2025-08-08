import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:Theme"
import "root:Components"
import Quickshell.Services.Notifications

PanelWindow {
    id: root
    property var modelData: screen
    property bool showAll: Server.showall
    onShowAllChanged: {
        visible = false;
        visible = true;
    }
    screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor.name)
    anchors {
        top: true
        right: true
    }
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    implicitHeight: screen.height
    implicitWidth: 500
    WlrLayershell.layer: WlrLayer.Overlay
    color: "transparent"
    component NotifList: ListView {
        implicitWidth: 1000
        delegate: NotificationItem {}
        spacing: 5
        add: Transition {
            NumberAnimation {
                properties: "x"
                from: 500
                duration: 400
                easing.type: Easing.OutQuint
            }
        }
        remove: Transition {
            NumberAnimation {
                properties: "x"
                to: 500
                duration: 400
                easing.type: Easing.OutQuint
            }
        }
        displaced: Transition {
            NumberAnimation {
                properties: "x,y"
                duration: 400
                easing.type: Easing.OutQuint
            }
        }
    }
    WrapperItem {
        id: historyItem
        topMargin: 10
        visible: Server.showall
        NotifList {
            id: historyView
            model: Server.notifs
            implicitHeight: Math.min(historyView.contentHeight, 1000)
        }
    }
    WrapperItem {
        id: currentItem
        topMargin: 10
        visible: !Server.showall
        NotifList {
            id: currentView
            implicitHeight: Math.min(currentView.contentHeight, 1000)
            model: Server.current
        }
    }
    mask: Region {
        item: Server.showall ? historyItem : currentItem
    }
}
