import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Mpris
import "root:Theme"
import "root:Components"

RowLayout {
    id: root
    Layout.preferredWidth: 300
    Text {
        color: Theme.fg3
        text: `${inMinutes(Player.p.position)}`
    }
    StyledSlider {
        thickness: 10
        Layout.fillWidth: true
        from: 0
        to: Player.p?.length
        value: Player.p?.position
        onMoved: Player.p?.seek(value - Player.p?.position)
        Timer {
            // only emit the signal when the position is actually changing.
            running: root.visible && Player.p?.playbackState == MprisPlaybackState.Playing
            // Make sure the position updates at least once per second.
            interval: 1000
            repeat: true
            // emit the positionChanged signal every second.
            onTriggered: Player.p?.positionChanged()
        }
    }
    Text {
        color: Theme.fg3
        text: `${inMinutes(Player.p?.length)}`
    }

    function inMinutes(seconds): string {
        var secondsrounded = Math.round(seconds);
        var minutes = Math.floor(secondsrounded / 60);
        var seconds2 = secondsrounded % 60;
        return `${minutes < 10 ? "0" : ""}${minutes}:${seconds2 < 10 ? "0" : ""}${seconds2}`;
    }
}
