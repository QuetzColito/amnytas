import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.Theme
import Quickshell.Io
import qs.Components

Item {
    id: root
    anchors.fill: parent
    property var model
    Component.onCompleted: getClients.running = true
    onVisibleChanged: getClients.running = true

    RowLayout {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 5
        height: 30
        ThemedText {
            text: "Hyprland Clients"
            font.pointSize: 20
        }
        IconButton {
            name: "arrow-counter-clockwise"
            color: Theme.cyan
            clickable.onClicked: getClients.running = true
        }
    }

    Process {
        id: getClients
        command: ["sh", "-c", `hyprctl clients -j | jq "map({class, title, wsid: .workspace.id})"`]
        stdout: StdioCollector {
            onStreamFinished: {
                root.model = JSON.parse(text.trim());
            }
        }
    }

    ScrollView {
        id: scroll
        implicitHeight: Math.min(content.height, 370)
        implicitWidth: content.width + 15
        anchors.margins: 5
        anchors.topMargin: 10
        Behavior on implicitHeight {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 200
            }
        }
        anchors.top: header.bottom
        anchors.left: parent.left
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
                    id: entry
                    required property var modelData
                    height: grid.height + 20
                    width: grid.width + 15
                    border.width: 2
                    border.color: Theme.blue
                    color: "transparent"
                    GridLayout {
                        id: grid
                        width: 375
                        anchors.centerIn: parent
                        columns: 2
                        ThemedText {
                            id: name
                            Layout.maximumWidth: 350
                            Layout.fillWidth: true

                            elide: Qt.ElideRight
                            color: Theme.blue
                            text: entry.modelData.title
                        }
                        ThemedText {
                            text: "WS"
                            color: Theme.fg4
                        }
                        ThemedText {
                            id: windowclass
                            Layout.maximumWidth: 350
                            Layout.fillWidth: true

                            elide: Qt.ElideRight
                            color: Theme.cyan
                            text: entry.modelData.class
                        }
                        ThemedText {
                            text: entry.modelData.wsid || ""
                        }
                    }
                }
            }
        }
    }
}
