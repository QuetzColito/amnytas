pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Theme

Slider {
    id: control
    property string fillColor: Theme.blue
    property string bgColor: Theme.bg3
    property string handleColor: fillColor
    property int length: 200
    property int thickness: 20
    padding: 0
    background: GridLayout {
        implicitWidth: control.horizontal ? control.length : control.thickness
        implicitHeight: control.horizontal ? control.thickness : control.length
        rows: control.horizontal ? 1 : control.length
        columns: control.horizontal ? control.length : 1
        columnSpacing: 3
        rowSpacing: 3

        Repeater {
            model: control.length / 5
            Rectangle {
                required property int modelData
                property int progress: (control.horizontal ? control.visualPosition : control.visualPosition) * control.length / 5
                property bool filled: control.horizontal ? modelData < progress : modelData > progress
                color: filled ? control.fillColor : control.bgColor
                implicitWidth: control.horizontal ? 2 : control.thickness
                implicitHeight: control.horizontal ? control.thickness : 2
            }
        }

        // Rectangle {
        //     anchors.bottom: control.horizontal ? undefined : parent.bottom
        //     width: control.horizontal ? control.visualPosition * (parent.width - control.thickness) + control.thickness : parent.width
        //     height: control.horizontal ? parent.height : (1 - control.visualPosition) * (parent.height - control.thickness) + control.thickness
        //     radius: control.thickness / 2
        //     color: control.fillColor
        // }
    }

    handle: Item {
        y: control.horizontal ? 0 : control.visualPosition * (control.availableHeight - height)
        x: control.horizontal ? control.visualPosition * (control.availableWidth - width) : 0
        implicitWidth: control.thickness
        implicitHeight: control.thickness
    }
}
