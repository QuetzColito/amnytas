import QtQuick
import QtQuick.Controls
import qs.Theme

Slider {
    id: control
    property string fillColor: Theme.blue
    property string bgColor: Theme.bg3
    property string handleColor: fillColor
    property int length: 200
    property int thickness: 20
    padding: 0
    background: Rectangle {
        color: control.bgColor
        radius: control.thickness / 2
        implicitWidth: control.horizontal ? control.length : control.thickness
        implicitHeight: control.horizontal ? control.thickness : control.length

        Rectangle {
            anchors.bottom: control.horizontal ? undefined : parent.bottom
            width: control.horizontal ? control.visualPosition * (parent.width - control.thickness) + control.thickness : parent.width
            height: control.horizontal ? parent.height : (1 - control.visualPosition) * (parent.height - control.thickness) + control.thickness
            radius: control.thickness / 2
            color: control.fillColor
        }
    }

    handle: Rectangle {
        y: control.horizontal ? 0 : control.visualPosition * (control.availableHeight - height)
        x: control.horizontal ? control.visualPosition * (control.availableWidth - width) : 0
        implicitWidth: control.thickness
        implicitHeight: control.thickness
        radius: control.thickness / 2
        color: control.pressed ? control.handleColor : control.fillColor
    }
}
