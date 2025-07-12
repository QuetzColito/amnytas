import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick.Layouts
import "root:Theme"
import "root:Components"

WrapperItem {
    rightMargin: 30
    RowLayout {
        id: root
        Text {
            color: Theme.fg
            text: Player.p?.trackTitle || "Unknown Title"
        }
        Text {
            color: Theme.fg3
            text: Player.p?.trackArtist || "Unknown Artist"
        }
        Progress {}
        ColumnLayout {
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                TextButton {
                    onClicked: Player.p.loopState = Player.p?.loopState == MprisLoopState.Track ? MprisLoopState.None : Player.p?.loopState == MprisLoopState.Playlist ? MprisLoopState.Track : MprisLoopState.Playlist
                    text.text: Player.p?.loopState == MprisLoopState.Track ? "󰑘 " : Player.p?.loopState == MprisLoopState.Playlist ? "󰑖 " : "󰑗"
                }
                TextButton {
                    onClicked: Player.p.shuffle = true
                    text.text: " "
                }
            }
            BaseButtons {}
        }
        Item {
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200
            Image {
                anchors.centerIn: parent
                source: Player.p.trackArtUrl
                width: 150
                height: 150
                fillMode: Image.PreserveAspectFit
            }
        }
        StyledSlider {
            value: Player.p.volume
            orientation: Qt.Vertical
            onMoved: Player.p.volume = value
        }
    }
    function inMinutes(seconds): string {
        var secondsrounded = Math.round(seconds);
        var minutes = Math.floor(secondsrounded / 60);
        var seconds2 = secondsrounded % 60;
        return `${minutes < 10 ? "0" : ""}${minutes}:${seconds2 < 10 ? "0" : ""}${seconds2}`;
    }
}
