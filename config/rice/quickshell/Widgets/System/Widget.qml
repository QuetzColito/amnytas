import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import qs.Theme
import qs.Services
import qs.Components

RowLayout {
    id: root
    implicitHeight: Math.max(tabs.height, loader.height)
    implicitWidth: tabs.width + loader.width
    // spacing: 30
    property string currentTab: "BluetoothTab.qml"
    WrapperItem {
        extraMargin: 5
        topMargin: 10
        Layout.alignment: Qt.AlignTop
        ColumnLayout {
            id: tabs
            spacing: 20
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
        Layout.fillHeight: true
        source: root.currentTab
    }
}
