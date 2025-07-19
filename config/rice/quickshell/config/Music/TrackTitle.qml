import QtQuick
import QtQuick.Layouts
import "root:Theme"

Text {
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    color: Theme.purple
    text: Player.p?.trackTitle || "Unknown Title"
}
