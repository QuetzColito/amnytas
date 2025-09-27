import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick
import Quickshell.Widgets
import qs.Theme
import qs.Components

WrapperMouseArea {
    id: root
    property int value: 6
    property int max: 6
    onWheel: e => max = Math.max(1, e.angleDelta.y > 0 ? max + 1 : max - 1)
    onClicked: randomize.start()
    Rectangle {
        implicitWidth: 80
        implicitHeight: 80
        radius: 10
        color: Theme.blue
        GridLayout {
            anchors.centerIn: parent
            height: 70
            width: 70
            columns: 3
            visible: root.max < 9
            uniformCellHeights: true
            uniformCellWidths: true
            Rectangle {
                color: [4, 5, 6, 7, 8].includes(root.value) ? Theme.bg : Theme.blue
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 20
            }

            CenteredText {
                text: root.max
                color: Theme.bg
                font.pointSize: 20
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Repeater {
                model: [[2, 3, 4, 5, 6, 7, 8], [6, 7, 8], [1, 3, 5, 7, 8], [6, 7, 8], [2, 3, 4, 5, 6, 7, 8], [8], [4, 5, 6, 7, 8]]
                Rectangle {
                    required property var modelData
                    color: modelData.includes(root.value) ? Theme.bg : Theme.blue
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 20
                }
            }
        }

        Item {
            anchors.fill: parent
            visible: max > 8
            CenteredText {
                anchors.bottom: parent.verticalCenter
                anchors.top: parent.top
                anchors.right: parent.horizontalCenter
                anchors.left: parent.left
                font.pointSize: 30
                text: value
            }

            CenteredText {
                font.pointSize: 30
                anchors.top: parent.verticalCenter
                anchors.bottom: parent.bottom
                anchors.left: parent.horizontalCenter
                anchors.right: parent.right
                text: max
            }

            Shape {
                anchors.fill: parent
                ShapePath {
                    strokeWidth: 0
                    fillColor: Theme.bg
                    startX: 10
                    startY: 65
                    PathLine {
                        x: 65
                        y: 10
                    }
                    PathLine {
                        x: 70
                        y: 15
                    }
                    PathLine {
                        x: 15
                        y: 70
                    }
                }
            }
        }

        SequentialAnimation {
            id: randomize
            ScriptAction {
                script: value = Math.ceil(Math.random() * max)
            }
            PauseAnimation {
                duration: 20
            }
            ScriptAction {
                script: value = Math.ceil(Math.random() * max)
            }
            PauseAnimation {
                duration: 40
            }
            ScriptAction {
                script: value = Math.ceil(Math.random() * max)
            }
            PauseAnimation {
                duration: 70
            }
            ScriptAction {
                script: value = Math.ceil(Math.random() * max)
            }
            PauseAnimation {
                duration: 100
            }
            ScriptAction {
                script: value = Math.ceil(Math.random() * max)
            }
            PauseAnimation {
                duration: 150
            }
            ScriptAction {
                script: value = Math.ceil(Math.random() * max)
            }
        }
    }
}
