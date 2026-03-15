import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Components
import qs.Services
import qs.Theme

RowLayout {
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    implicitWidth: 300
    spacing: 15
    IconToggleButton {
        icon.size: 35
        activeColor: Theme.blue
        // inactiveColor: "transparent"
        clickable.onClicked: MprisService.p.loopState = MprisService.p?.loopState == MprisLoopState.Track ? MprisLoopState.None : MprisService.p?.loopState == MprisLoopState.Playlist ? MprisLoopState.Track : MprisLoopState.Playlist
        active: MprisService.p?.loopState == MprisLoopState.Track || MprisService.p?.loopState == MprisLoopState.Playlist
        name: MprisService.p?.loopState == MprisLoopState.Track ? "repeat-once" : "repeat"
        border.width: 0
    }
    IconButton {
        size: 35
        clickable.onClicked: MprisService.p.previous()
        name: "back"
    }
    IconButton {
        size: 35
        clickable.onClicked: MprisService.p.togglePlaying()
        name: MprisService.p?.isPlaying ? "pause" : "play"
    }
    IconButton {
        size: 35
        clickable.onClicked: MprisService.p.next()
        name: "forward"
    }
    IconToggleButton {
        icon.size: 35
        activeColor: Theme.blue
        clickable.onClicked: MprisService.p.shuffle = true
        active: MprisService.p?.shuffle
        name: "shuffle"
        border.width: 0
    }
}
