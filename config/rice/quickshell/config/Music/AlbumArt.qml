import QtQuick

Item {
    implicitWidth: 250
    implicitHeight: art.height + 25
    Image {
        id: art
        anchors.centerIn: parent
        width: 225
        source: Player.p.trackArtUrl
        fillMode: Image.PreserveAspectFit
    }
}
