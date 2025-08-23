import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt.labs.platform

PanelWindow {
    id: root
    property var modelData

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "qs-background"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: modelData.height
    implicitWidth: modelData.width

    property url home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
    property int wsid: Hyprland.monitorFor(modelData).activeWorkspace?.id || "1"
    property string rotation: modelData.height > modelData.width ? "v" : ""
    property url current: `${home}/amnytas/wallpaper/${wsid}${rotation}.png`

    // who needs complicated animations lol
    onCurrentChanged: {
        visible = false;
        visible = true;
    }

    Image {
        id: backup
        source: `${root.home}/amnytas/wallpaper/1${root.rotation}.png`
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: main.status === Image.Error
    }

    Image {
        id: main
        anchors.fill: parent
        source: root.current
        fillMode: Image.PreserveAspectCrop
        visible: main.status !== Image.Error
    }
}
