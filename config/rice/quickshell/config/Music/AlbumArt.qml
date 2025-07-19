import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts

// Item {
// Layout.preferredWidth: 200
// Layout.preferredHeight: 200
Item {
    implicitWidth: 250
    implicitHeight: art.height + 25
    Image {
        id: art
        anchors.centerIn: parent
        width: 225
        // anchors.centerIn: parent
        source: Player.p.trackArtUrl
        fillMode: Image.PreserveAspectFit
    }
}
// }
