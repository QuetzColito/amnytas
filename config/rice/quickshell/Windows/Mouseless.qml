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
    property string selecting: ""
    color: "transparent"
    Clickable {
        onClicked: root.visible = false
    }

    Loader {
        id: mouselessLoader
        active: false
        anchors.fill: parent
        onActiveChanged: sourceComponent = active ? mouselessComponent : undefined
    }

    Component {
        id: mouselessComponent

        RowLayout {
            id: layout
            anchors.fill: parent
            spacing: 0

            Shortcut {
                sequence: " "
                onActivated: {
                    Quickshell.execDetached(["sh", "-c", `ydotool click 0xc0`]);
                    root.set_active(false);
                }
            }
            Shortcut {
                sequences: [StandardKey.InsertParagraphSeparator]
                onActivated: {
                    Quickshell.execDetached(["sh", "-c", `ydotool click 0xc1`]);
                    root.set_active(false);
                }
            }
            Shortcut {
                sequences: [StandardKey.Cancel]
                onActivated: root.set_active(false)
            }
            Shortcut {
                sequences: [StandardKey.MoveToNextChar]
                onActivated: Quickshell.execDetached(["sh", "-c", `pos=$(hyprctl cursorpos -j); hyprctl dispatch movecursor "$(echo $pos | jq ".x + 10")" "$(echo $pos | jq ".y")"`])
            }
            Shortcut {
                sequences: [StandardKey.MoveToPreviousChar]
                onActivated: Quickshell.execDetached(["sh", "-c", `pos=$(hyprctl cursorpos -j); hyprctl dispatch movecursor "$(echo $pos | jq ".x - 10")" "$(echo $pos | jq ".y")"`])
            }
            Shortcut {
                sequences: [StandardKey.MoveToNextLine]
                onActivated: Quickshell.execDetached(["sh", "-c", `pos=$(hyprctl cursorpos -j); hyprctl dispatch movecursor "$(echo $pos | jq ".x")" "$(echo $pos | jq ".y + 10")"`])
            }
            Shortcut {
                sequences: [StandardKey.MoveToPreviousLine]
                onActivated: Quickshell.execDetached(["sh", "-c", `pos=$(hyprctl cursorpos -j); hyprctl dispatch movecursor "$(echo $pos | jq ".x")" "$(echo $pos | jq ".y - 10")"`])
            }
            Repeater {
                model: ["A", "S", "D", "F", "G", "H", "J", "K", "L", ";"]
                delegate: ColumnLayout {
                    id: column
                    required property string modelData
                    spacing: 0

                    Layout.fillHeight: true

                    Shortcut {
                        sequence: column.modelData
                        onActivated: root.selecting = column.modelData
                        enabled: root.selecting === ""
                    }

                    Repeater {
                        model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/"]
                        delegate: Rectangle {
                            id: inner
                            required property string modelData

                            implicitWidth: (root.width) / 10
                            implicitHeight: (root.height) / 30
                            color: column.modelData === root.selecting || column.modelData + inner.modelData === root.selecting ? Theme.bg2 : Theme.bg

                            ThemedText {
                                anchors.centerIn: parent
                                text: column.modelData + " " + inner.modelData
                                visible: root.selecting !== column.modelData + inner.modelData
                            }

                            Loader {
                                id: gridLoader
                                onLoaded: {
                                    item.xOffset = root.screen.x + column.x;
                                    item.yOffset = root.screen.y + inner.y;
                                    item.name = column.modelData + inner.modelData;
                                }
                                anchors.fill: parent
                                active: root.selecting === column.modelData + inner.modelData
                                onActiveChanged: sourceComponent = active ? smallGridComponent : undefined
                            }

                            Shortcut {
                                sequence: inner.modelData
                                onActivated: {
                                    const x = Math.round(root.screen.x + column.x + inner.width / 2);
                                    const y = Math.round(root.screen.y + inner.y + inner.height / 2);
                                    Quickshell.execDetached(["sh", "-c", `hyprctl dispatch movecursor "${x}" "${y}"`]);
                                    root.selecting = root.selecting + inner.modelData;
                                }
                                enabled: root.selecting === column.modelData
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: smallGridComponent
        GridLayout {
            id: smallGrid
            property int xOffset
            property int yOffset
            property string name
            visible: root.selecting === name
            rowSpacing: 0
            columnSpacing: 0
            columns: 10
            anchors.fill: parent
            Repeater {
                model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/"]
                delegate: Item {
                    id: kernel
                    required property string modelData

                    implicitWidth: (parent.width - 45) / 10
                    implicitHeight: (parent.height - 150) / 30

                    ThemedText {
                        anchors.centerIn: parent
                        text: kernel.modelData
                    }

                    Shortcut {
                        sequence: kernel.modelData
                        enabled: {
                            return root.selecting === smallGrid.name;
                        }
                        onActivated: {
                            const x = Math.round(smallGrid.xOffset + kernel.x + kernel.width / 2);
                            const y = Math.round(smallGrid.yOffset + kernel.y + kernel.height / 2);
                            Quickshell.execDetached(["sh", "-c", `hyprctl dispatch movecursor "${x}" "${y}"; ydotool click 0xc0`]);
                            root.selecting = "";
                            root.visible = false;
                        }
                    }
                }
            }
        }
    }

    function set_active(active: bool): void {
        mouselessLoader.active = active;
        root.visible = active;
        root.selecting = "";
        if (active)
            mouselessLoader.sourceComponent = mouselessComponent;
        else
            mouselessLoader.sourceComponent = undefined;
    }

    IpcHandler {
        target: "mouseless"

        function activate(): void {
            root.set_active(true);
        }
        function deactivate(): void {
            root.set_active(false);
        }
    }
}
