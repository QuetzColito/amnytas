import QtQuick
import qs.Services

Item {
    implicitWidth: 250
    implicitHeight: art.height + 25
    Image {
        id: art
        anchors.centerIn: parent
        width: 225
        source: MprisService.p?.trackArtUrl || ""
        fillMode: Image.PreserveAspectFit
    }
}
