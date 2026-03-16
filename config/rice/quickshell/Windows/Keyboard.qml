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
        anchors.fill: parent
        anchors.margins: 5
        spacing: 2
        Repeater {
            model: KBLayout.layout
            delegate: RowLayout {
                id: row
                required property var modelData
                spacing: 2

                readonly property int defaultWeight: 10
                property double widthWeightSum: modelData.reduce((partialSum, a) => partialSum + (a?.width || defaultWeight), 0)
                property double widthSum: layout.width - (modelData.length - 1) * row.spacing

                Repeater {
                    model: row.modelData
                    delegate: Rectangle {
                        id: button
                        required property var modelData

                        implicitWidth: ((modelData.width || row.defaultWeight) / row.widthWeightSum) * row.widthSum
                        implicitHeight: (layout.height - (KBLayout.layout.length - 1) * layout.spacing) / KBLayout.layout.length
                        radius: 2
                        border.color: Theme.blue
                        border.width: 1
                        color: root.clearable_modifiers.includes(modelData.code) ? Theme.blue : Theme.bg

                        Clickable {
                            onPressed: root.sendKey(`${button.modelData.code}:1`)
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
                            ThemedText {
                                color: Theme.blue
                                text: `${button.modelData.label}`
                            }
                            ThemedText {
                                visible: button.modelData.shiftLabel || false

                                color: Theme.fg4
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
        function enable(): void {
            root.visible = true;
        }
        function disable(): void {
            root.visible = false;
        }
    }

    function sendKey(code: string): void {
        Quickshell.execDetached(["sh", "-c", `ydotool key ${code}`]);
    }
}
