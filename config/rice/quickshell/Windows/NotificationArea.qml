import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Services

PanelWindow {
    id: root
    property var modelData: screen
    property bool showAll: NotificationService.showall
    exclusionMode: ExclusionMode.Ignore
    onShowAllChanged: {
        visible = false;
        visible = true;
    }
    screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor?.name) || null
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
    WlrLayershell.namespace: "qs-notif"
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
        visible: NotificationService.showall
        NotifList {
            id: historyView
            model: NotificationService.notifs
            implicitHeight: Math.min(historyView.contentHeight, 1000)
        }
    }
    WrapperItem {
        id: currentItem
        topMargin: 10
        visible: !NotificationService.showall
        NotifList {
            id: currentView
            implicitHeight: Math.min(currentView.contentHeight, 1000)
            model: NotificationService.current
        }
    }
    mask: Region {
        item: NotificationService.showall ? historyItem : currentItem
    }
}
