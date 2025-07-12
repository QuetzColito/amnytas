import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "root:Theme"
import "root:Components"

RowLayout {
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    TextButton {
        onClicked: Player.p.previous()
        text.text: " 󰼨 "
    }
    TextButton {
        onClicked: Player.p.togglePlaying()
        text.text: Player.p?.isPlaying ? "  " : "  "
    }
    TextButton {
        onClicked: Player.p.next()
        text.text: " 󰼧 "
    }
}
