import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../Theme"

Rectangle {
    id: background
    required property QsMenuEntry modelData
    width: 225
    height: modelData.isSeparator ? 1 : 20
    color: modelData.isSeparator ? Colors.fg2 : Colors.bg
    RowLayout {
        anchors.centerIn: parent
        visible: !modelData.isSeparator
        Text {
            id: iconBefore
            color: Colors.fg
            text: modelData.checkState == Qt.Checked ? "" : ""
            visible: modelData.buttonType == QsMenuButtonType.CheckBox
        }
        Text {
            id: text
            text: modelData.text
            color: Colors.fg
        }
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: background
        onExited: () => background.color = Colors.bg
        onEntered: () => background.color = Colors.bg2
        onClicked: () => modelData.triggered()
    }
}
