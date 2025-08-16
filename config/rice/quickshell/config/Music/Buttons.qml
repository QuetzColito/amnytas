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
        IconButton {
            size: 50
            clickable.onClicked: Player.p.loopState = Player.p?.loopState == MprisLoopState.Track ? MprisLoopState.None : Player.p?.loopState == MprisLoopState.Playlist ? MprisLoopState.Track : MprisLoopState.Playlist
            name: Player.p?.loopState == MprisLoopState.Track ? "repeat_one_on" : Player.p?.loopState == MprisLoopState.Playlist ? "repeat_on" : "repeat"
        }
        IconButton {
            size: 50
            clickable.onClicked: Player.p.previous()
            name: "previous"
        }
        IconButton {
            size: 50
            clickable.onClicked: Player.p.togglePlaying()
            name: Player.p?.isPlaying ? "pause" : "play"
        }
        IconButton {
            size: 50
            clickable.onClicked: Player.p.next()
            name: "next"
        }
        IconButton {
            size: 50
            clickable.onClicked: Player.p.shuffle = true
            name: Player.p?.shuffle ? "shuffle_on" : "shuffle"
        }
    }
}
