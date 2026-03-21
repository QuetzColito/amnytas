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
    anchors.centerIn: parent
    implicitWidth: 100

    Behavior on implicitHeight {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    InfoRow {
        id: networkingRow
        name: "Networking"
        valueAsIcon: true
        implicitWidth: 380
        clickable.onClicked: NetworkService.toggleNetworking()
        value: NetworkService.networking ? "check-square" : "check-empty"
        valueColor: NetworkService.networking ? Theme.cyan : Theme.red
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
        value: NetworkService.wifiEnabled ? "check-square" : "check-empty"
        valueColor: NetworkService.wifiEnabled ? Theme.cyan : Theme.red
    }

    ThemedText {
        color: Theme.purple
        font.pointSize: 15
        visible: NetworkService.hasWifi
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

        ThemedText {
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
                TextInput {
                    id: passwordInput
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    color: Theme.blue
                    echoMode: TextInput.Password
                    onTextChanged: passwordItem.password = text
                    onAccepted: {
                        NetworkService.connectNew(passwordItem.ssid, passwordItem.password);
                        passwordItem.visible = false;
                    }
                }
            }
        }

        IconButton {
            id: submit
            anchors.right: parent.right
            anchors.verticalCenter: passwordField.verticalCenter
            name: "send"
            clickable.onClicked: {
                NetworkService.connectNew(passwordItem.ssid, passwordItem.password);
                passwordItem.visible = false;
            }
        }
    }

    ScrollView {
        id: scroll
        implicitHeight: Math.min(content.height, 290)
        implicitWidth: 380
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
                            color: Theme.purple
                            name: "star"
                            size: 18
                            visible: network.modelData.use
                        }
                        ThemedText {
                            id: ssid
                            color: network.modelData.use ? Theme.purple : Theme.blue
                            Layout.fillWidth: true
                            text: network.modelData.ssid
                        }
                        ColoredIcon {
                            id: strengthIcon
                            property int strength: network.modelData.strength
                            color: strength > 66 ? Theme.cyan : strength > 33 ? Theme.blue : Theme.purple
                            name: strength > 75 ? "wifi-3" : strength > 50 ? "wifi-2" : strength > 25 ? "wifi-1" : "wifi-0"
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
                                passwordInput.text = "";
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
