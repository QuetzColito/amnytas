import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Components
import qs.Services

WrapperItem {
    leftMargin: 35
    topMargin: -5
    bottomMargin: 5
    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        IconButton {
            size: 50
            clickable.onClicked: MprisService.p.loopState = MprisService.p?.loopState == MprisLoopState.Track ? MprisLoopState.None : MprisService.p?.loopState == MprisLoopState.Playlist ? MprisLoopState.Track : MprisLoopState.Playlist
            name: MprisService.p?.loopState == MprisLoopState.Track ? "repeat_one_on" : MprisService.p?.loopState == MprisLoopState.Playlist ? "repeat_on" : "repeat"
        }
        IconButton {
            size: 50
            clickable.onClicked: MprisService.p.previous()
            name: "previous"
        }
        IconButton {
            size: 50
            clickable.onClicked: MprisService.p.togglePlaying()
            name: MprisService.p?.isPlaying ? "pause" : "play"
        }
        IconButton {
            size: 50
            clickable.onClicked: MprisService.p.next()
            name: "next"
        }
        IconButton {
            size: 50
            clickable.onClicked: MprisService.p.shuffle = true
            name: MprisService.p?.shuffle ? "shuffle_on" : "shuffle"
        }
    }
}
