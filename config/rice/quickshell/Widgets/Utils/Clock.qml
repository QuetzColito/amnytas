import QtQuick.Layouts
import QtQuick
import Quickshell
import qs.Theme
import qs.Components

Item {
    anchors.fill: parent
    CenteredText {
        id: left
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -80
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "hh")
        color: Theme.cyan
        font.pointSize: 50
    }
    CenteredText {
        id: mid
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Layout.fillWidth: true
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "mm")
        color: Theme.blue
        font.pointSize: 50
    }
    CenteredText {
        id: right
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 80
        Layout.fillWidth: true
        text: clock.date.toLocaleString(Qt.locale("de_DE"), "ss")
        color: Theme.bg4
        font.pointSize: 50
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
