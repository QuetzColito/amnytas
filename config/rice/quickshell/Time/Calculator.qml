import QtQuick.Layouts
import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import qs.Theme
import qs.Components

Item {
    Layout.fillWidth: true
    Layout.preferredHeight: 50

    ColoredIcon {
        id: icon
        padding: 4
        color: Theme.blue
        name: "calc"
    }
    WrapperMouseArea {
        anchors.right: parent.right
        anchors.left: icon.right
        cursorShape: Qt.IBeamCursor
        WrapperRectangle {
            radius: 5
            extraMargin: 3
            color: Theme.bg3
            TextInput {
                id: input
                text: ""
                color: Theme.blue
                onTextChanged: {
                    calc.tocalc = text;
                    calc.running = true;
                }
            }
        }
    }

    Text {
        id: mid
        anchors.bottom: parent.bottom
        text: " = "
        color: Theme.blue
    }

    WrapperMouseArea {
        onClicked: copy.running = true
        anchors.left: mid.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Text {
            id: resultbox
            anchors.fill: parent
            color: Theme.blue
            horizontalAlignment: Text.AlignRight
            text: ""
        }
    }

    Process {
        id: calc
        property string tocalc
        command: ["sh", "-c", `putah "${tocalc}"`]
        stdout: StdioCollector {
            onStreamFinished: resultbox.text = text.replace(/(\r\n|\n|\r)/gm, "")
        }
    }

    Process {
        id: copy
        command: ["sh", "-c", "wl-copy " + resultbox.result]
    }
}
