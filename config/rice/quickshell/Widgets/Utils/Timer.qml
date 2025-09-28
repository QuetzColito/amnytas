pragma ComponentBehavior: Bound
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Theme
import qs.Components

GridLayout {
    id: root
    property int value: 0
    property int valueBu: 0
    property string color: timer.running ? Theme.purple : Theme.orange
    columns: 4
    Wheel {
        id: hours
        currentIndex: Math.floor(root.value / 3600)
        onCurrentIndexChanged: {
            root.value = currentIndex * 3600 + root.value % 3600;
        }
    }
    Wheel {
        id: minutes
        currentIndex: Math.floor((root.value % 3600) / 60)
        onCurrentIndexChanged: {
            root.value = Math.floor(root.value / 3600) * 3600 + currentIndex * 60 + root.value % 60;
        }
    }
    Wheel {
        id: seconds
        currentIndex: root.value % 60
        onCurrentIndexChanged: {
            root.value = Math.floor(root.value / 60) * 60 + currentIndex;
        }
    }
    TimerButton {
        name: timer.running ? "pause" : "play"
        clickable.onClicked: {
            if (!timer.running)
                root.valueBu = root.value;
            timer.running = !timer.running;
        }
    }
    TimerButton {
        name: "restart"
        clickable.onClicked: {
            root.valueBu = 0;
            root.value = 0;
        }
    }
    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            root.value--;
            if (root.value < 1) {
                running = false;
                root.value = root.valueBu;
                Quickshell.execDetached(["sh", "-c", "mpg123 $HOME/amnytas/config/rice/quickshell/Widgets/Utils/kurukuru.mp3"]);
            }
        }
    }
    component TimerButton: IconButton {
        color: root.color
        size: 50
    }
    component Wheel: Tumbler {
        id: tumbler

        visibleItemCount: 5
        model: 60
        Layout.rowSpan: 2
        contentItem.implicitHeight: 130
        contentItem.implicitWidth: 25
        delegate: Text {
            required property int modelData
            color: modelData == tumbler.currentIndex ? root.color : Theme.fg3
            text: modelData
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
        }
        Clickable {
            onWheel: e => tumbler.positionViewAtIndex(tumbler.currentIndex + (e.angleDelta.y > 0 ? -1 : 1), Tumbler.Center)
        }
    }
}
