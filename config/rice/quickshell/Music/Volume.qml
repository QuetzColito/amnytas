import QtQuick
import QtQuick.Layouts
import qs.Theme
import qs.Components

ColumnLayout {
    spacing: 10
    property StyledSlider slider: item

    StyledSlider {
        id: item
        length: 100
        value: Player.p?.volume || 0
        orientation: Qt.Vertical
        onMoved: Player.p.volume = value
    }

    Text {
        color: Theme.blue
        text: " "
    }
}
