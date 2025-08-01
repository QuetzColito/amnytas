import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:Theme"
import "root:Components"

Item {
    id: root
    implicitWidth: 200
    implicitHeight: 100
    property int value: 0
    property int valueBu: 0
    property string color: timer.running ? Theme.purple : Theme.orange

    GridLayout {
        anchors.fill: parent
        uniformCellHeights: true
        uniformCellWidths: true
        columns: 3
        Wheel {
            magnitude: 3600
            bound: 86400
            deco: "H"
        }
        Wheel {
            magnitude: 60
            bound: 3600
            deco: "M"
        }
        Wheel {
            magnitude: 1
            bound: 60
            deco: "S"
        }
        MaxedButton {
            text.text: {
                if (!timer.running || (value / valueBu) > .66)
                    return " ";
                if ((value / valueBu) > .33)
                    return " ";
                return " ";
            }
        }
        MaxedButton {
            text.text: timer.running ? "" : ""
            onClicked: {
                if (!timer.running)
                    valueBu = value;
                timer.running = !timer.running;
            }
        }
        MaxedButton {
            text.text: "󰜉"
            onClicked: value = valueBu
        }
    }
    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            value--;
            if (value < 1) {
                running = false;
                value = valueBu;
                Quickshell.execDetached(["sh", "-c", "mpg123 $HOME/amnytas/config/rice/quickshell/config/Time/kurukuru.mp3"]);
            }
        }
    }
    component MaxedButton: TextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        text.color: root.color
        text.font.pointSize: 25
    }
    component Wheel: WrapperMouseArea {
        property int magnitude
        property int bound
        property string deco
        Layout.fillWidth: true
        Layout.fillHeight: true
        onWheel: e => value = Math.max(0, e.angleDelta.y > 0 ? value + magnitude : value - magnitude)
        CenteredText {
            color: root.color
            text: {
                const v = Math.floor((value % bound) / magnitude);
                return `${v < 10 ? "0" : ""}${v}${deco}`;
            }
        }
    }
}
