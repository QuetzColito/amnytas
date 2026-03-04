import QtQuick
import qs.Theme
import qs.Components
import qs.Services

IconButton {
    property int yOffset: 30
    name: !NotificationService.dnd ? "notification" : "notification_off"
    size: 23
    color: !NotificationService.showall ? Theme.blue : Theme.fg

    clickable.onClicked: event => {
        if (event.button === Qt.LeftButton) {
            NotificationService.dnd = !NotificationService.dnd;
        } else {
            NotificationService.showall = !NotificationService.showall;
        }
    }
}
