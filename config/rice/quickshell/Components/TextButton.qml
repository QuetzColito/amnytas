import QtQuick
import Quickshell.Widgets
import qs.Theme

WrapperMouseArea {
    acceptedButtons: Qt.RightButton | Qt.LeftButton
    cursorShape: Qt.PointingHandCursor
    property Text text: innerText
    Text {
        id: innerText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 30
        color: Theme.purple
    }
}
