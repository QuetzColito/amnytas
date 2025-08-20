import QtQuick
import Quickshell.Widgets
import qs.Theme

Rectangle {
    id: root
    property Clickable clickable: click
    property Item item: itemm
    property ColoredIcon icon: iconn
    property Text text: textt
    required property string name
    property string altName
    property bool active: false
    property color activeColor: Theme.purple
    property color inactiveColor: Theme.bg
    property real margin: 5
    implicitHeight: itemm.height + 2 * margin
    implicitWidth: itemm.width + 2 * margin
    border.width: 2
    border.color: activeColor
    radius: 7

    color: active ? activeColor : "transparent"
    Behavior on color {
        ColorAnim {}
    }

    Item {
        id: itemm
        anchors.centerIn: parent
        implicitWidth: iconn.width + textt.width
        implicitHeight: Math.max(iconn.height, textt.height)
        ColoredIcon {
            id: iconn
            name: !root.active && root.altName ? root.altName : root.name

            color: root.active ? root.inactiveColor : root.activeColor
            Behavior on color {
                ColorAnim {}
            }
        }
        Text {
            id: textt
            anchors.left: iconn.right
            anchors.verticalCenter: iconn.verticalCenter

            color: root.active ? root.inactiveColor : root.activeColor
            Behavior on color {
                ColorAnim {}
            }
        }
    }

    Clickable {
        id: click
    }

    component ColorAnim: ColorAnimation {
        easing.type: Easing.InOutQuad
        duration: 200
    }
}
