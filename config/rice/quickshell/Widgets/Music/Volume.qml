import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Components
import qs.Services

ColumnLayout {
    spacing: 10
    property StyledSlider slider: item

    StyledSlider {
        id: item
        length: 100
        value: MprisService.p?.volume || 0
        orientation: Qt.Vertical
        onMoved: MprisService.p.volume = value
    }

    Text {
        color: Theme.blue
        text: " "
    }
}
