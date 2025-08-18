import QtQuick
import qs.Theme
import qs.Components

TextButton {
    property int yOffset: 30
    text.text: !Server.dnd ? "" : ""
    text.font.pointSize: 14
    text.color: !Server.showall ? Theme.purple : Theme.orange
    implicitWidth: 15

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            Server.dnd = !Server.dnd;
        } else {
            Server.showall = !Server.showall;
        }
    }
}
