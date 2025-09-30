pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Theme
import qs.Components
import "keyboardLayout.js" as KBLayout

PanelWindow {
    id: root
    visible: false
    WlrLayershell.layer: WlrLayer.Overlay
    screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor?.name) || null
    property list<int> modifiers: [42, 54, 29, 125, 56, 97]
    property list<int> clearable_modifiers: []
    WlrLayershell.namespace: "qs-keyboard"
    color: "transparent"

    anchors {
        left: true
        right: true
        bottom: true
    }
    implicitHeight: 300

    ColumnLayout {
        id: layout
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 9
            topMargin: 0
        }
        Repeater {
            model: KBLayout.layout
            delegate: RowLayout {
                id: row
                Layout.fillWidth: true
                Layout.fillHeight: true
                required property var modelData
                Repeater {
                    model: row.modelData
                    delegate: Rectangle {
                        id: button
                        required property var modelData
                        Layout.fillWidth: modelData.width == undefined
                        Layout.fillHeight: true

                        Layout.minimumWidth: modelData.width != undefined ? row.width / modelData.width : 0
                        radius: 7
                        border.color: Theme.blue
                        border.width: 2
                        color: root.clearable_modifiers.includes(modelData.code) ? Theme.blue : Theme.bg

                        Clickable {
                            onPressed: {
                                if (root.modifiers.includes(button.modelData.code)) {
                                    root.sendKey(`${button.modelData.code}:1`);
                                } else {
                                    root.sendKey(`${button.modelData.code}:1`);
                                }
                            }
                            onReleased: {
                                if (root.modifiers.includes(button.modelData.code)) {
                                    if (root.clearable_modifiers.includes(button.modelData.code)) {
                                        root.sendKey(`${button.modelData.code}:0`);
                                        root.clearable_modifiers = root.clearable_modifiers.filter(c => c != button.modelData.code);
                                    } else
                                        root.clearable_modifiers.push(button.modelData.code);
                                } else {
                                    root.sendKey(`${button.modelData.code}:0`);
                                    while (root.clearable_modifiers.length > 0) {
                                        root.sendKey(`${root.clearable_modifiers.pop()}:0`);
                                    }
                                }
                            }
                        }

                        RowLayout {
                            anchors.centerIn: parent
                            Text {
                                color: Theme.blue
                                text: `${button.modelData.label}`
                            }
                            Text {
                                visible: button.modelData.shiftLabel || false

                                color: Theme.fg3
                                text: `${button.modelData.shiftLabel}`
                            }
                        }
                    }
                }
            }
        }
    }

    IpcHandler {
        id: ipc
        target: "keyboard"
        function toggle(): void {
            root.visible = !root.visible;
        }
    }

    function sendKey(code: string): void {
        Quickshell.execDetached(["sh", "-c", `ydotool key ${code}`]);
    }
}
