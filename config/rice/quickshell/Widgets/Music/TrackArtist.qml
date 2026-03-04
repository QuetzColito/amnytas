import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Services
import qs.Components

ThemedText {
    Layout.fillWidth: true
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    color: Theme.blue
    text: MprisService.p?.trackArtist || "Unknown Artist"
    horizontalAlignment: Text.AlignRight
    elide: Qt.ElideRight
}
