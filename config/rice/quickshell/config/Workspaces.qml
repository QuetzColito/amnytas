import QtQuick.Layouts
import Quickshell.Hyprland
import QtQuick
import "root:Theme"

RowLayout {
    id: layout
    anchors.margins: 10
    property real textsize: 11

    component WsIndicator: Text {
        property int wsid
        property var ws: Hyprland.workspaces.values.find(ws => ws.id == wsid)
        text: ws !== undefined ? " ◆ " : " ◇ "
        color: ws?.focused ? Theme.purple : Theme.blue
        font.pointSize: layout.textsize
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            onClicked: e => e.button == Qt.LeftButton ? Hyprland.dispatch(`workspace ${wsid}`) : Hyprland.dispatch(`movetoworkspace ${wsid}`)
        }
    }

    component Separator: Text {
        text: "|"
        color: Theme.fg2
        font.pointSize: layout.textsize
    }

    WsIndicator {
        wsid: 1
    }
    WsIndicator {
        wsid: 2
    }
    WsIndicator {
        wsid: 3
    }
    Separator {}
    WsIndicator {
        wsid: 4
    }
    WsIndicator {
        wsid: 5
    }
    WsIndicator {
        wsid: 6
    }
    Separator {}
    WsIndicator {
        wsid: 7
    }
    WsIndicator {
        wsid: 8
    }
    WsIndicator {
        wsid: 9
    }
}
