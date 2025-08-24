pragma ComponentBehavior: Bound
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.Theme
import qs.Components
import qs.Services

ColumnLayout {
    id: root
    Behavior on implicitHeight {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    InfoRow {
        name: "Networking"
        valueAsIcon: true
        clickable.onClicked: NetworkService.toggleNetworking()
        value: NetworkService.networking ? "check_circle" : "circle"
        valueColor: NetworkService.networking ? Theme.green : Theme.red
    }

    InfoRow {
        name: "Connectivity"
        value: NetworkService.connectivity.trim()
    }

    InfoRow {
        name: "Wifi Enabled"
        valueAsIcon: true
        visible: NetworkService.hasWifi
        clickable.onClicked: NetworkService.toggleWifi()
        value: NetworkService.wifiEnabled ? "check_circle" : "circle"
        valueColor: NetworkService.wifiEnabled ? Theme.green : Theme.red
    }

    Text {
        color: Theme.purple
        font.pointSize: 15
        text: "Available Networks:"
    }

    Timer {
        running: root.visible
        interval: 15000
        repeat: true
        onTriggered: NetworkService.reScan()
        triggeredOnStart: true
    }

    Item {
        id: passwordItem
        property string ssid: ""
        property string password: ""
        Layout.fillWidth: true
        visible: false
        implicitHeight: passwordtext.height + passwordField.height + 5

        Text {
            id: passwordtext
            color: Theme.red
            wrapMode: Text.WordWrap
            width: parent.width - submit.width
            text: `New Network ${passwordItem.ssid}, enter Password:`
        }
        WrapperMouseArea {
            id: passwordField
            anchors.left: parent.left
            anchors.right: submit.left
            anchors.top: passwordtext.bottom
            anchors.topMargin: 5
            anchors.rightMargin: 5
            cursorShape: Qt.IBeamCursor
            WrapperRectangle {
                color: Theme.bg3
                radius: 5
                TextInput {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    onTextChanged: passwordItem.password = text
                    onAccepted: NetworkService.connectNew(passwordItem.ssid, passwordItem.password)
                }
            }
        }

        IconButton {
            id: submit
            anchors.right: parent.right
            anchors.verticalCenter: passwordField.verticalCenter
            name: "send"
            clickable.onClicked: NetworkService.connectNew(passwordItem.ssid, passwordItem.password)
        }
    }

    ScrollView {
        id: scroll
        implicitHeight: Math.min(content.height, 300)
        implicitWidth: content.width + 15
        Behavior on implicitHeight {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 200
            }
        }
        ScrollBar.vertical.contentItem: Rectangle {
            implicitWidth: 6
            radius: 7
            color: Theme.bg3
        }
        ColumnLayout {
            id: content

            Repeater {
                model: NetworkService.wifiEnabled ? NetworkService.networks : []

                delegate: Item {
                    id: network
                    required property var modelData
                    property string password: ""
                    property bool waitingForPassword: false
                    Layout.fillWidth: true
                    implicitHeight: entry.height + 10
                    implicitWidth: entry.width
                    RowLayout {
                        id: entry
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.right: parent.right
                        implicitWidth: activeIcon.width + ssid.width + strengthIcon.width + 30
                        ColoredIcon {
                            id: activeIcon
                            color: Theme.orange
                            name: "star"
                            size: 18
                            visible: network.modelData.use
                        }
                        Text {
                            id: ssid
                            color: network.modelData.use ? Theme.orange : Theme.fg
                            Layout.fillWidth: true
                            text: network.modelData.ssid
                        }
                        ColoredIcon {
                            id: strengthIcon
                            property int strength: network.modelData.strength
                            color: strength > 66 ? Theme.green : strength > 33 ? Theme.yellow : Theme.red
                            name: strength > 66 ? "wifi" : strength > 33 ? "wifi_2_bar" : "wifi_1_bar"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    Clickable {
                        onClicked: {
                            passwordItem.visible = false;
                            const uuid = (NetworkService.canConnect(network.modelData.ssid));
                            if (uuid) {
                                NetworkService.connect(uuid);
                            } else {
                                passwordItem.ssid = network.modelData.ssid;
                                passwordItem.visible = true;
                            }
                        }
                    }
                }
            }
        }
    }
}
