pragma ComponentBehavior: Bound
import QtQuick.Layouts
import Quickshell.Hyprland
import QtQuick
import qs.Theme
import qs.Components

RowLayout {
    id: layout
    anchors.margins: 10
    property real textsize: 11

    component WsIndicator: IconButton {
        id: indicator
        property int wsid
        property var ws: Hyprland.workspaces.values.find(ws => ws.id == wsid)
        name: ws?.toplevels.values.length > 0 ? "diamond_full" : "diamond_empty"
        color: ws?.focused ? Theme.purple : Theme.blue
        size: 25
        image.sourceSize: Qt.size(width * 10, height * 10)
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            onClicked: e => e.button == Qt.LeftButton ? Hyprland.dispatch(`workspace ${indicator.wsid}`) : Hyprland.dispatch(`movetoworkspace ${indicator.wsid}`)
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
