import QtQuick
import Quickshell.Widgets
import "root:Theme"

WrapperMouseArea {
    acceptedButtons: Qt.RightButton | Qt.LeftButton
    cursorShape: Qt.PointingHandCursor
    property Text text: innerText
    Text {
        id: innerText
        font.pointSize: 30
        color: Theme.purple
    }
}
