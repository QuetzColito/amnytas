import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.Theme
import Quickshell.Hyprland
import qs.Components
import qs.Services

Item {
    id: root
    anchors.fill: parent

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
            clickable.onClicked: {
                Hyprland.refreshToplevels();
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
                model: {
                    Hyprland.refreshToplevels();
                    return Hyprland.toplevels;
                }

                delegate: Rectangle {
                    id: entry
                    required property HyprlandToplevel modelData
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
                            text: {
                                Hyprland.refreshToplevels();
                                return entry.modelData.lastIpcObject.class;
                            }
                        }
                        ThemedText {
                            text: entry.modelData.workspace.id
                        }
                    }
                }
            }
        }
    }
}
