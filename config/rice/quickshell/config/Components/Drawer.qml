import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.Shapes
import qs.Theme

ColumnLayout {
    id: root
    property Item smallItem
    property Item bigItem
    property bool isOpen: big.visible
    property bool isDrawn: false
    property bool isIn: !isDrawn
    property bool hasLeftCorners: false
    property bool hasRightCorners: false
    property bool isMid: hasLeftCorners && hasRightCorners
    property var alignment
    property int dx: isIn ? (isMid ? 40 : 20) : (isMid ? big.width - small.width / 2 : big.width - small.width)
    property int xl: !isIn ? x + big.x : x + small.x
    property int xr: !isIn ? x + big.x + big.width : x + small.x + small.width

    spacing: 0

    Rectangle {
        id: big

        implicitWidth: bigItem.width + 10
        implicitHeight: bigItem.height + 10
        Layout.alignment: root.alignment
        color: Theme.bg
        bottomRightRadius: hasRightCorners && root.dx > 0 ? Math.min(10, dx / 2) : 0
        bottomLeftRadius: hasLeftCorners && root.dx > 0 ? Math.min(10, dx / 2) : 0
        visible: !isIn
        WrapperItem {
            anchors.horizontalCenter: parent.horizontalCenter
            child: bigItem
        }
        Corner.BottomLeft {
            visible: hasRightCorners && root.dx < 0 && isDrawn
            radius: Math.min(20, Math.abs(dx / 2))
            anchors.left: big.right
            anchors.bottom: big.bottom
        }
        Corner.BottomRight {
            visible: hasLeftCorners && root.dx < 0 && isDrawn
            radius: Math.min(20, Math.abs(dx / 2))
            anchors.right: big.left
            anchors.bottom: big.bottom
        }
    }

    Rectangle {
        id: small
        Layout.alignment: root.alignment
        implicitWidth: smallItem.width + 10
        implicitHeight: Theme.barheight
        color: Theme.bg

        WrapperItem {
            anchors.centerIn: parent
            child: smallItem
        }

        topRightRadius: hasRightCorners && root.dx < 0 ? Math.min(10, Math.abs(dx) / 2) : 0
        topLeftRadius: hasLeftCorners && root.dx < 0 ? Math.min(10, Math.abs(dx) / 2) : 0
        bottomRightRadius: hasRightCorners ? 10 : 0
        bottomLeftRadius: hasLeftCorners ? 10 : 0

        Corner.TopRight {
            visible: hasLeftCorners && isDrawn && root.dx > 0
            radius: Math.min(root.dx, 20)
            anchors.right: small.left
        }
        Corner.TopLeft {
            visible: hasRightCorners && isDrawn && root.dx > 0
            radius: Math.min(root.dx, 20)
            anchors.left: small.right
        }
    }
    NumberAnimation on y {
        id: anim
        duration: 150
        easing.type: Easing.InOutQuad
        onStopped: () => {
            if (!root.isDrawn) {
                isIn = true;
                root.y = 0;
            }
        }
    }

    function toggle(): void {
        if (!root.isDrawn) {
            root.y = -big.height;
            isIn = false;
            root.isDrawn = true;
            anim.to = 0;
            anim.start();
        } else {
            root.isDrawn = false;
            anim.to = -big.height;
            anim.start();
        }
    }
    function disable(): void {
        if (root.isDrawn)
            toggle();
    }
    function enable(): void {
        if (!root.isDrawn)
            toggle();
    }
}
