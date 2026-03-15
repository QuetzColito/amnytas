import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Theme
import qs.Components

RowLayout {
    id: root
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    ThemedText {
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "ddd")
        color: Theme.blue
    }
    ColoredIcon {
        name: "calendar"
    }
    ThemedText {
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "dd MMM")
        color: Theme.blue
    }
    ColoredIcon {
        name: "clock"
    }
    ThemedText {
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "hh:mm")
        color: Theme.blue
    }
}
