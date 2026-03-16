pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Theme
import qs.Components

PanelWindow {
    id: root
    screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor?.name) || null
    visible: false

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "qs-mouseless"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: screen.height
    implicitWidth: screen.width
    color: "transparent"
    RowLayout {
        id: layout
        anchors.fill: parent
        property string selecting: ""
        Repeater {
            model: ["A", "S", "D", "F", "G", "H", "J", "K", "L", ";"]
            delegate: ColumnLayout {
                id: column
                Layout.fillHeight: true
                required property string modelData
                Shortcut {
                    sequence: column.modelData
                    onActivated: layout.selecting = column.modelData
                    enabled: layout.selecting === ""
                }
                Repeater {
                    model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "/"]
                    delegate: Rectangle {
                        id: inner
                        implicitWidth: (root.width - 45) / 10
                        implicitHeight: (root.height - 150) / 30

                        required property string modelData
                        color: Theme.bg
                        ThemedText {
                            anchors.centerIn: parent
                            text: column.modelData + " " + inner.modelData
                        }
                        Shortcut {
                            sequence: inner.modelData
                            onActivated: {
                                const x = Math.round(root.screen.x + column.x + inner.width / 2);
                                const y = Math.round(root.screen.y + inner.y + inner.height / 2);
                                Quickshell.execDetached(["sh", "-c", `hyprctl dispatch movecursor "${x} ${y}"; ydotool click 0xc0`]);
                                layout.selecting = "";
                                root.visible = false;
                            }
                            enabled: layout.selecting === column.modelData
                        }
                    }
                }
            }
        }
    }

    Clickable {
        onClicked: root.visible = false
    }

    IpcHandler {
        target: "mouseless"

        function activate(): void {
            root.visible = true;
        }
    }
}
