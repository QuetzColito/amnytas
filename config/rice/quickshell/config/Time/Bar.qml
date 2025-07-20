import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell
import "root:Theme"

Text {
    id: root
    text: clock.date.toLocaleString(Qt.locale("de_DE"), "ddd   dd MMM   hh:mm")
    color: Theme.orange
    font.pointSize: Theme.textsize
    elide: Text.ElideRight
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
