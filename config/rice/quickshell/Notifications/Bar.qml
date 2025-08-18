import QtQuick
import qs.Theme
import qs.Components

IconButton {
    property int yOffset: 30
    name: !Server.dnd ? "notification" : "notification_off"
    size: 23
    color: !Server.showall ? Theme.purple : Theme.orange

    clickable.onClicked: event => {
        if (event.button === Qt.LeftButton) {
            Server.dnd = !Server.dnd;
        } else {
            Server.showall = !Server.showall;
        }
    }
}
