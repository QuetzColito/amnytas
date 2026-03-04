import QtQuick
import Quickshell
import qs.Theme
import qs.Components

ThemedText {
    id: root
    text: clock.date.toLocaleString(Qt.locale("de_DE"), "ddd   dd MMM  hh:mm")
    color: Theme.blue
    elide: Text.ElideRight
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
