import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import "root:Shapes"
import "root:Theme"
import "root:Components"
import "root:Music" as Music
import "root:Audio" as Audio
import "root:Widgets"

PanelWindow {
    id: barwindow
    property var modelData
    anchors {
        top: true
        left: true
        right: true
    }
    color: "transparent"

    implicitHeight: screen.height
    exclusiveZone: 30

    Drawer {
        id: leftarea
        hasRightCorners: true
        alignment: Qt.AlignLeft
        smallItem: RowLayout {
            Text {
                font.pointSize: 18
                color: Theme.cyan
                text: ""
                Clickable {
                    onClicked: leftarea.toggle()
                }
            }
            Workspaces {}
        }
        bigItem: System {}
    }
    Corner.TopLeft {
        x: leftarea.xr
    }
    Corner.TopRight {
        x: midarea.xl - 20
    }

    Drawer {
        id: midarea
        anchors.horizontalCenter: parent.horizontalCenter
        alignment: Qt.AlignHCenter
        hasRightCorners: true
        hasLeftCorners: true
        smallItem: Time {
            Clickable {
                onClicked: midarea.toggle()
            }
        }
        bigItem: System {}
    }
    Corner.TopLeft {
        x: midarea.xr
        // visible: rightarea.xl - midarea.xr > 40
        radius: Math.min(20, (rightarea.xl - midarea.xr) / 2)
        visible: radius > 0
    }
    Corner.TopRight {
        x: rightarea.xl - radius
        radius: Math.min(20, (rightarea.xl - midarea.xr) / 2)
        visible: radius > 0
    }

    Drawer {
        id: rightarea
        isDrawn: true
        anchors.right: parent.right
        alignment: Qt.AlignRight
        hasLeftCorners: true
        smallItem: RowLayout {
            Music.BarIndicator {
                Layout.maximumWidth: screen.width / 2 - volume.width - midarea.width / 2 - 30
                Clickable {
                    acceptedButtons: Qt.RightButton
                    onClicked: rightarea.toggle()
                }
            }
            Audio.Volume {
                id: volume
            }
        }
        bigItem: Music.Widget {}
    }

    Corner.BottomLeft {
        y: screen.height - 20
    }
    Corner.BottomRight {
        y: screen.height - 20
        x: screen.width - 20
    }
    Corner.TopLeft {
        anchors.top: leftarea.bottom
    }
    Corner.TopRight {
        anchors.top: rightarea.bottom
        anchors.right: rightarea.right
    }

    component Clickable: MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
    }

    mask: Region {
        item: rightarea
        Region {
            item: midarea
        }
        Region {
            item: leftarea
        }
    }
}
