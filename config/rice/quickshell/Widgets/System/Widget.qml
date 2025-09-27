import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import qs.Theme
import qs.Services
import qs.Components

RowLayout {
    id: root
    implicitHeight: Math.max(tabs.height, loader.height) + 15
    implicitWidth: tabs.width + loader.width
    // spacing: 30
    property string currentTab: "SoundTab.qml"
    WrapperItem {
        extraMargin: 5
        topMargin: 10
        bottomMargin: 10
        Layout.alignment: Qt.AlignTop
        ColumnLayout {
            id: tabs
            spacing: 20
            IconButton {
                name: "dash"
                color: Theme.red
                clickable.onClicked: root.currentTab = "MonitorTab.qml"
            }
            IconButton {
                name: "wifi"
                color: Theme.orange
                clickable.onClicked: root.currentTab = "NetworkTab.qml"
            }
            IconButton {
                name: "bluetooth"
                color: Theme.blue
                clickable.onClicked: root.currentTab = "BluetoothTab.qml"
                visible: BluetoothService.isPresent
            }
            IconButton {
                name: "volume"
                clickable.onClicked: root.currentTab = "SoundTab.qml"
            }
        }
    }
    Loader {
        id: loader
        Layout.alignment: Qt.AlignTop
        source: root.currentTab
    }
}
