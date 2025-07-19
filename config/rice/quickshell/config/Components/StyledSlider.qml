import QtQuick
import QtQuick.Controls
import "root:Theme"

Slider {
    id: control
    property string fillColor: Theme.blue
    property string bgColor: Theme.bg3
    property string handleColor: fillColor
    property int length: 200
    property int thickness: 20
    background: Rectangle {
        color: bgColor
        radius: thickness / 2
        implicitWidth: horizontal ? length : thickness
        implicitHeight: horizontal ? thickness : length

        Rectangle {
            anchors.bottom: horizontal ? undefined : parent.bottom
            width: horizontal ? control.visualPosition * (parent.width - thickness) + thickness : parent.width
            height: horizontal ? parent.height : (1 - control.visualPosition) * (parent.height - thickness) + thickness
            radius: thickness / 2
            color: fillColor
        }
    }

    handle: Rectangle {
        y: horizontal ? 0 : control.visualPosition * (control.availableHeight - height)
        x: horizontal ? control.visualPosition * (control.availableWidth - width) : 0
        implicitWidth: thickness
        implicitHeight: thickness
        radius: thickness / 2
        color: control.pressed ? handleColor : fillColor
    }
}
