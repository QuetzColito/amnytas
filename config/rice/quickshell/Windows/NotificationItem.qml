pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.Notifications
import Quickshell
import Quickshell.Hyprland
import QtQuick.Layouts
import qs.Theme
import qs.Components
import qs.Services

Rectangle {
    id: root
    x: 300
    required property var modelData
    property bool fresh: modelData.expiresAt > clock.date.getTime()
    implicitWidth: 490
    implicitHeight: Math.max(img.height + 10, contentLayout.height + 10)
    onFreshChanged: if (!fresh)
        NotificationService.expire(modelData.id)
    color: Theme.bg
    border.color: Theme.cyan
    border.width: 2
    radius: 7

    Layout.maximumHeight: modelData.body || modelData.image ? 200 : title.height + 10
    anchors.margins: 30

    Item {
        id: img
        implicitWidth: modelData.image !== "" ? 80 : 5
        implicitHeight: modelData.image !== "" ? 80 : 1
        anchors.verticalCenter: parent.verticalCenter
        Image {
            source: modelData.image || Quickshell.iconPath(modelData.image, true)
            anchors.centerIn: parent
            width: 64
            height: 64
            fillMode: Image.PreserveAspectFit
        }
    }
    ColumnLayout {
        id: contentLayout
        y: 5
        anchors.left: img.right
        implicitWidth: 485 - img.width
        spacing: 0
        Text {
            id: title
            Layout.maximumWidth: parent.width
            text: modelData.summary
            font.bold: true
            font.pointSize: 15
            color: Theme.fg
            wrapMode: Text.Wrap
            elide: Text.ElideRight
        }
        Text {
            id: body
            Layout.maximumWidth: parent.width
            Layout.maximumHeight: 190 - title.height
            text: modelData.body
            font.features: {
                "liga": 0,
                "calt": 0,
                "clig": 0,
                "dlig": 0,
                "hlig": 0
            }
            color: Theme.fg
            wrapMode: Text.Wrap
            elide: Text.ElideRight
        }
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        onClicked: event => {
            if (event.button === Qt.LeftButton) {
                const actions = root.modelData.notif.actions;
                Hyprland.dispatch(`focuswindow 'class:^.*(${root.modelData.notif.appName}).*$'`);
                if (actions.length === 1) {
                    actions[0].invoke();
                    NotificationService.expire(modelData.id);
                }
            } else {
                if (NotificationService.showall)
                    NotificationService.yeet(modelData.id);
                else
                    NotificationService.expire(modelData.id);
            }
        }
    }
}
