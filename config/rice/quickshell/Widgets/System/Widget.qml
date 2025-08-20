import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import qs.Theme
import qs.Components

RowLayout {
    id: root
    implicitHeight: Math.max(tabs.height, loader.height)
    implicitWidth: tabs.width + loader.width
    spacing: 30
    property string currentTab: "SoundTab.qml"
    ColumnLayout {
        id: tabs
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignTop
        spacing: 30
        IconButton {
            name: "dash"
            clickable.onClicked: root.currentTab = "MonitorTab.qml"
        }
        IconButton {
            name: "wifi"
            clickable.onClicked: root.currentTab = "NetworkTab.qml"
        }
        IconButton {
            name: "bluetooth"
            clickable.onClicked: root.currentTab = "BluetoothTab.qml"
        }
        IconButton {
            name: "volume"
            clickable.onClicked: root.currentTab = "SoundTab.qml"
        }
    }
    Loader {
        id: loader
        Layout.fillHeight: true
        source: root.currentTab
    }
}
