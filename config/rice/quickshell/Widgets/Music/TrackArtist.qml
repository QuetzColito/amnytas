import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Services

Text {
    Layout.fillWidth: true
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    color: Theme.fg3
    text: MprisService.p?.trackArtist || "Unknown Artist"
    horizontalAlignment: Text.AlignRight
}
