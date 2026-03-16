import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth
import qs.Theme
import Quickshell.Widgets
import qs.Components
import qs.Services

Item {
    id: root
    implicitHeight: scroll.height + buttons.height
    implicitWidth: Math.max(scroll.width, buttons.width)

    property var model: BluetoothService.devices

    Component.onCompleted: BluetoothService.defaultAdapter.pairable = true

    WrapperItem {
        id: buttons
        topMargin: 10
        bottomMargin: 10
        rightMargin: 15
        leftMargin: 5
        RowLayout {
            IconToggleButton {
                id: enabled
                active: BluetoothService.enabled
                name: BluetoothService.enabled ? "bluetooth" : "bluetooth-slash"
                text.text: BluetoothService.enabled ? "Enabled" : "Disabled"
                clickable.onClicked: BluetoothService.defaultAdapter.enabled = !BluetoothService.defaultAdapter.enabled
            }

            IconToggleButton {
                id: scan
                name: "bluetooth-connected"
                active: BluetoothService.discovering
                clickable.onClicked: BluetoothService.scan(!BluetoothService.discovering)
                text.text: BluetoothService.discovering ? "Scanning" : "Scan"
            }

            IconToggleButton {
                id: pairable
                name: "bluetooth-connected"
                active: BluetoothService.defaultAdapter.pairable
                clickable.onClicked: BluetoothService.togglePairable()
                text.text: pairable.active ? "Pairable" : "Unpairable"
            }
        }
    }

    ScrollView {
        id: scroll
        visible: BluetoothService.enabled
        implicitHeight: Math.min(content.height, 500)
        implicitWidth: content.width + 15
        Behavior on implicitHeight {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 200
            }
        }
        anchors.top: buttons.bottom
        anchors.left: parent.left
        anchors.leftMargin: 5
        ScrollBar.vertical.contentItem: Rectangle {
            implicitWidth: 6
            color: Theme.bg3
        }
        ColumnLayout {
            id: content
            spacing: 10
            Behavior on height {
                NumberAnimation {
                    duration: 1000
                }
            }
            Repeater {
                model: root.model

                delegate: Rectangle {
                    id: device
                    required property BluetoothDevice modelData
                    property string displayName: modelData.name || modelData.deviceName
                    height: grid.height + 20
                    width: grid.width + 15
                    border.width: 2
                    border.color: Theme.blue
                    color: "transparent"
                    Clickable {
                        onClicked: device.modelData.connected = !device.modelData.connected
                    }
                    ColumnLayout {
                        id: grid
                        height: 70
                        width: 375
                        anchors.centerIn: parent
                        RowLayout {
                            ThemedText {
                                id: name
                                Layout.maximumWidth: 325

                                elide: Qt.ElideRight
                                text: device.displayName
                            }
                            BatteryIcon {
                                visible: device.modelData.batteryAvailable
                                battery: device.modelData.battery
                            }
                        }
                        RowLayout {
                            IconToggleButton {
                                id: connect
                                Layout.fillWidth: true
                                text.font.pointSize: 15
                                active: device.modelData.connected
                                activeColor: Theme.blue
                                clickable.onClicked: device.modelData.connected = !device.modelData.connected
                                name: device.modelData.connected ? "check-square" : "check-empty"
                                text.text: device.modelData.connected ? "Connected" : "Disconnected"
                            }
                            IconToggleButton {
                                id: pair
                                Layout.fillWidth: true
                                text.font.pointSize: 15
                                active: device.modelData.paired
                                activeColor: Theme.blue
                                clickable.onClicked: device.modelData.paired ? device.modelData.forget() : device.modelData.pairing ? device.modelData.cancelPair() : device.modelData.pair()
                                name: device.modelData.paired ? "check-square" : device.modelData.pairing ? "dots" : "check-empty"
                                text.text: device.modelData.paired ? "Paired" : device.modelData.pairing ? "Pairing" : "Unpaired"
                            }
                            IconToggleButton {
                                id: trust
                                Layout.fillWidth: true
                                text.font.pointSize: 15
                                active: device.modelData.trusted
                                activeColor: Theme.blue
                                clickable.onClicked: device.modelData.trusted = !device.modelData.trusted
                                name: device.modelData.trusted ? "check-square" : "check-empty"
                                text.text: device.modelData.trusted ? "Trusted" : "Untrusted"
                            }
                        }
                    }
                }
            }
        }
    }
}
