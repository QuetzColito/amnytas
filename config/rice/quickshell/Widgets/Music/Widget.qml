import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Components

ColumnLayout {
    implicitHeight: parent.height - 30
    implicitWidth: parent.width - 30
    anchors.centerIn: parent
    spacing: (340 - meta.height - art.height) / 3
    visible: title.visible
    ColumnLayout {
        id: meta
        spacing: 10
        TrackTitle {
            id: title
            maximumLineCount: 3
        }
        TrackArtist {
            maximumLineCount: 4 - title.lineCount
        }
    }

    WrapperItem {
        leftMargin: -3
        RowLayout {
            id: artLayout
            spacing: 28
            AlbumArt {
                id: art
            }
            Volume {
                slider.length: art.implicitHeight - 60
            }
        }
    }

    Buttons {}

    Progress {}
}
