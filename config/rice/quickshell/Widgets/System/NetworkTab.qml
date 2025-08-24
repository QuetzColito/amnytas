import QtQuick.Layouts
import QtQuick
import qs.Theme
import qs.Components
import qs.Services

ColumnLayout {
    Text {
        color: Theme.fg
        text: "Network"
    }
    TextButton {
        onClicked: NetworkService.reScan()
        text.text: "A"
    }
    Text {
        color: Theme.fg
        visible: NetworkService.hasWifi
        text: "HasWifi"
    }
}
