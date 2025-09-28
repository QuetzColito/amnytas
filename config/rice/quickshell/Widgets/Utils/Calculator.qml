pragma ComponentBehavior: Bound
import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Theme
import qs.Components

Item {
    id: root
    implicitWidth: 250
    implicitHeight: 360

    Rectangle {
        id: inputbox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        implicitHeight: 30
        implicitWidth: 235
        radius: 5
        color: Theme.bg3

        Clickable {
            cursorShape: Qt.IBeamCursor
        }
        TextInput {
            id: input
            anchors.centerIn: parent
            height: 20
            width: 225
            text: ""
            color: Theme.blue
            horizontalAlignment: Text.AlignRight
            onTextChanged: {
                calc.tocalc = text;
                calc.running = true;
            }
        }
    }

    Rectangle {
        id: separator
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: inputbox.bottom
        anchors.margins: 10
        implicitHeight: 2
        color: Theme.blue
    }

    Text {
        id: resultbox
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: separator.bottom
        anchors.margins: 5
        color: Theme.blue
        horizontalAlignment: Text.AlignRight
        text: "0"
        font.pointSize: 15
        Clickable {
            onClicked: Quickshell.execDetached(["sh", "-c", "wl-copy " + resultbox.text])
        }
    }

    GridLayout {
        id: buttonGrid
        anchors.top: resultbox.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15
        columns: 4

        CalcButton {
            text: "xⁱ"
            clickable.onClicked: input.text = input.text + "^"
        }
        CalcButton {
            text: "√"
            clickable.onClicked: input.text = "sqrt(" + input.text + ")"
        }
        CalcButton {
            text: "C"
            clickable.onClicked: input.text = input.text.substring(0, input.text.length - 1)
            textColor: Theme.red
        }
        CalcButton {
            text: "AC"
            clickable.onClicked: input.text = ""
            textColor: Theme.red
        }

        SymbolButton {
            symbol: "1"
        }
        SymbolButton {
            symbol: "2"
        }
        SymbolButton {
            symbol: "3"
        }
        SymbolButton {
            symbol: "+"
            textColor: Theme.green
        }

        SymbolButton {
            symbol: "4"
        }
        SymbolButton {
            symbol: "5"
        }
        SymbolButton {
            symbol: "6"
        }
        SymbolButton {
            symbol: "-"
            textColor: Theme.green
        }
        SymbolButton {
            symbol: "7"
        }
        SymbolButton {
            symbol: "8"
        }
        SymbolButton {
            symbol: "9"
        }
        SymbolButton {
            symbol: "*"
            textColor: Theme.green
        }
        SymbolButton {
            text: "%"
            textColor: Theme.purple
        }
        SymbolButton {
            symbol: "0"
        }
        SymbolButton {
            symbol: "."
            textColor: Theme.purple
        }
        SymbolButton {
            symbol: "/"
            textColor: Theme.green
        }
    }

    component SymbolButton: CalcButton {
        property string symbol
        textColor: Theme.blue
        text: `${symbol}`
        clickable.onClicked: input.text = input.text + `${symbol}`
    }
    component CalcButton: Rectangle {
        property string text
        property string textColor: Theme.purple
        readonly property Clickable clickable: innerclick
        width: 55
        height: 40
        color: Theme.bg2
        radius: 10
        Text {
            font.pointSize: 25
            color: parent.textColor
            anchors.centerIn: parent
            text: parent.text
        }
        Clickable {
            id: innerclick
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
}
