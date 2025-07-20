import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell
import "root:Theme"
import "root:Components"

RowLayout {
    Layout.maximumWidth: 170
    Layout.alignment: Qt.AlignHCenter
    uniformCellSizes: true
    CenteredText {
        Layout.fillWidth: true
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "hh")
        color: Theme.red
        font.pointSize: 30
    }
    CenteredText {
        Layout.fillWidth: true
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "mm")
        color: Theme.blue
        font.pointSize: 30
    }
    CenteredText {
        Layout.fillWidth: true
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "ss")
        color: Theme.green
        font.pointSize: 30
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
