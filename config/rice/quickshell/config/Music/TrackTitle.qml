import QtQuick
import QtQuick.Layouts
import qs.Theme

Text {
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    color: Theme.purple
    text: Player.p?.trackTitle || "Unknown Title"
}
