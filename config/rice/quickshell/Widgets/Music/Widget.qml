import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Components

WrapperItem {
    topMargin: 15
    rightMargin: 20
    leftMargin: 15
    bottomMargin: 5
    ColumnLayout {
        TrackTitle {}
        TrackArtist {}
        RowLayout {
            spacing: 30
            AlbumArt {
                id: art
            }
            Volume {
                slider.length: art.implicitHeight - 60
            }
        }
        Buttons {}

        Progress {}
    }
}
