import QtQuick
import QtQuick.Layouts
import qs.Theme

Item {
    id: root
    required property string name
    property string nameColor: Theme.blue
    required property string value
    property bool valueAsIcon: false
    property string valueColor: Theme.fg
    property Clickable clickable: valueicon.clickable
    // implicitWidth: Math.max(300, nametext.width + valueAsIcon ? valueicon.width : valuetext.width)
    implicitHeight: Math.max(nametext.height, valueAsIcon ? valueicon.height : valuetext.height)
    Layout.fillWidth: true

    Text {
        id: nametext
        anchors.verticalCenter: parent.verticalCenter
        color: root.nameColor
        text: root.name + ":"
    }

    Text {
        id: valuetext
        color: root.valueColor
        text: root.value
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        visible: !root.valueAsIcon
    }

    IconButton {
        id: valueicon
        color: root.valueColor
        visible: root.valueAsIcon
        name: root.valueAsIcon ? root.value : "account"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }
}
