import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Services

Text {
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    color: Theme.purple
    text: MprisService.p?.trackTitle || "Unknown Title"
}
