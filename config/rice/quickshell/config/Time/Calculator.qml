import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:Theme"

Item {
    Layout.fillWidth: true
    Layout.preferredHeight: 40

    WrapperMouseArea {
        anchors.right: parent.horizontalCenter
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        cursorShape: Qt.IBeamCursor
        WrapperRectangle {
            radius: 5
            extraMargin: 3
            color: Theme.bg3
            TextInput {
                id: input
                text: ""
                color: Theme.blue
            }
        }
    }

    Text {
        id: mid
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: " = "
        color: Theme.blue
    }

    WrapperMouseArea {
        onClicked: copy.running = true
        anchors.left: mid.right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: resultbox
            anchors.fill: parent
            color: Theme.blue
            property string result: {
                try {
                    eval(input.text);
                } catch (err) {}
            }
            horizontalAlignment: Text.AlignRight
            text: result
        }
    }

    Process {
        id: copy
        command: ["sh", "-c", "wl-copy " + resultbox.result]
    }
}
