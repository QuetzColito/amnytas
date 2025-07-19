import QtQuick
import QtQuick.Layouts
import "root:Theme"

Text {
    Layout.fillWidth: true
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    color: Theme.fg3
    text: Player.p?.trackArtist || "Unknown Artist"
    horizontalAlignment: Text.AlignRight
}
