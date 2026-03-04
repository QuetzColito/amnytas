import QtQuick
import QtQuick.Layouts
import qs.Services
import qs.Components

ThemedText {
    Layout.maximumWidth: 300
    wrapMode: Text.WordWrap
    text: MprisService.p?.trackTitle || "Unknown Title"
    elide: Qt.ElideRight
}
