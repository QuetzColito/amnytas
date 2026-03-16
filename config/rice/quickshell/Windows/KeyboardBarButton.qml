import QtQuick
import Quickshell
import qs.Theme
import qs.Components
import qs.Services

IconButton {
    property int yOffset: 30
    name: "keyboard"
    size: 23
    color: !NotificationService.showall ? Theme.blue : Theme.fg

    clickable.onClicked: event => Quickshell.execDetached(["sh", "-c", "qs ipc call keyboard toggle"])
}
