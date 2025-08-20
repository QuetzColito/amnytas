import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.Theme
import qs.Components
import qs.Services

RowLayout {
    id: root
    Layout.preferredWidth: 300
    Text {
        color: Theme.fg3
        text: `${root.inMinutes(MprisService.p?.position || 0)}`
    }
    StyledSlider {
        thickness: 10
        Layout.fillWidth: true
        from: 0
        to: MprisService.p?.length || 0
        value: MprisService.p?.position || 0
        onMoved: MprisService.p?.seek(value - MprisService.p?.position)
        Timer {
            // only emit the signal when the position is actually changing.
            running: root.visible && MprisService.p?.playbackState == MprisPlaybackState.Playing
            // Make sure the position updates at least once per second.
            interval: 1000
            repeat: true
            // emit the positionChanged signal every second.
            onTriggered: MprisService.p?.positionChanged()
        }
    }
    Text {
        color: Theme.fg3
        text: `${root.inMinutes(MprisService.p?.length || 0)}`
    }

    function inMinutes(seconds): string {
        var secondsrounded = Math.round(seconds);
        var minutes = Math.floor(secondsrounded / 60);
        var seconds2 = secondsrounded % 60;
        return `${minutes < 10 ? "0" : ""}${minutes}:${seconds2 < 10 ? "0" : ""}${seconds2}`;
    }
}
