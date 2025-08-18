import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell.Widgets
import qs.Theme

Item {
    id: root
    property IconImage icon: iconn
    required property string name
    property real size: 20
    property color color: Theme.purple
    property Image image: iconn.backer
    property real padding: 0
    implicitWidth: size + 2 * padding
    implicitHeight: size + 2 * padding
    IconImage {
        id: iconn
        anchors.centerIn: parent
        implicitSize: root.size
        source: `root:Icons/${root.name}.svg`
    }
    ColorOverlay {
        anchors.fill: iconn
        source: iconn
        color: root.color
    }
}
