import QtQuick
import qs.Theme
import QtQuick.Layouts

Rectangle {
    id: root
    property var icontext: ""
    property var event: () => {}
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 100
    color: Theme.bg
    Text {
        id: icon
        anchors.centerIn: parent
        text: icontext
        color: Theme.blue
    }
    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        // onClicked: grid.month = (grid.month + 1) % 12
        onClicked: event()
        onEntered: root.color = Theme.bg2
        onExited: root.color = Theme.bg
    }
}
