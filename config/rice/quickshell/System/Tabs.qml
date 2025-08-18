import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import qs.Theme
import qs.Components

RowLayout {
    id: root
    property string currentTab: "MonitorTab.qml"
    ColumnLayout {
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
        source: root.currentTab
    }
}
