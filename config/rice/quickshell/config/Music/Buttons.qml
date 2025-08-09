import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Components

WrapperItem {
    leftMargin: 35
    topMargin: -5
    bottomMargin: 5
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        TextButton {
            text.font.pointSize: 20
            onClicked: Player.p.loopState = Player.p?.loopState == MprisLoopState.Track ? MprisLoopState.None : Player.p?.loopState == MprisLoopState.Playlist ? MprisLoopState.Track : MprisLoopState.Playlist
            text.text: Player.p?.loopState == MprisLoopState.Track ? " 󰑘 " : Player.p?.loopState == MprisLoopState.Playlist ? " 󰑖 " : " 󰑗 "
        }
        TextButton {
            onClicked: Player.p.previous()
            text.text: " 󰼨 "
        }
        TextButton {
            onClicked: Player.p.togglePlaying()
            text.text: Player.p?.isPlaying ? "  " : "  "
        }
        TextButton {
            onClicked: Player.p.next()
            text.text: " 󰼧 "
        }
        TextButton {
            text.font.pointSize: 20
            onClicked: Player.p.shuffle = true
            text.text: "  "
        }
    }
}
