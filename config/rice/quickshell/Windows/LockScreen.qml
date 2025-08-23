pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Components
import Quickshell.Services.Pam
import Qt.labs.platform

Scope {
    id: root
    property string input: ""
    property bool error: false

    WlSessionLock {
        id: lock

        WlSessionLockSurface {
            id: surface

            property url home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
            property int wsid: Hyprland.monitorFor(screen).activeWorkspace?.id || "1"
            property string rotation: screen?.height > screen?.width ? "v" : ""
            property url current: `${home}/amnytas/wallpaper/${wsid}${rotation}.png`

            color: "transparent"

            Rectangle {
                anchors.fill: parent

                Image {
                    id: backup
                    source: `${surface.home}/amnytas/wallpaper/1${surface.rotation}.png`
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    visible: main.status === Image.Error
                }

                Image {
                    id: main
                    anchors.fill: parent
                    source: surface.current
                    fillMode: Image.PreserveAspectCrop
                    visible: main.status !== Image.Error
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    implicitWidth: 400
                    color: Theme.bg

                    ColumnLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 50
                        spacing: 10

                        DisplayText {
                            font.pointSize: 70
                            font.weight: 700
                            text: clock.date.toLocaleString(Qt.locale("de_DE"), "hh:mm")
                        }

                        DisplayText {
                            font.pointSize: 25
                            text: clock.date.toLocaleString(Qt.locale("de_DE"), "dd. MMMM yyyy")
                        }

                        RowLayout {
                            ColoredIcon {
                                name: "account"
                                color: Theme.fg
                            }
                            DisplayText {
                                font.pointSize: 20
                                text: Quickshell.env("USER")
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }

                        Rectangle {
                            color: Theme.fg
                            implicitWidth: 250
                            implicitHeight: 30
                            radius: 15

                            TextInput {
                                id: input
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: root.input
                                font.pointSize: 15
                                focus: true
                                color: Theme.bg
                                echoMode: TextInput.Password
                                onTextChanged: root.input = input.text
                                onAccepted: pam.respond(input.text)
                                cursorDelegate: Item {}
                            }
                        }

                        Text {
                            font.family: "Inter Display"
                            font.pointSize: 15
                            color: Theme.red
                            text: "Authentication Error!"
                            visible: root.error
                        }
                    }
                    SystemClock {
                        id: clock
                        precision: SystemClock.Minutes
                    }
                }
            }
        }
    }

    component DisplayText: Text {
        font.family: "Inter Display"
        font.weight: 400
        color: Theme.fg
    }

    PamContext {
        id: pam
        configDirectory: "./pam/"
        onCompleted: result => {
            if (result == PamResult.Success) {
                lock.locked = false;
                root.error = false;
            } else {
                root.error = true;
                active = true;
            }
            root.input = "";
        }
    }

    IpcHandler {
        target: "lock"
        function lock(): void {
            lock.locked = true;
            pam.active = true;
        }
    }
}
