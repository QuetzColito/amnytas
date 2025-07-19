import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import "root:Theme"

WrapperMouseArea {
    id: root
    property QsMenuHandle modelData: parent.modelData
    property string button: modelData.buttonType == QsMenuButtonType.None ? "" : modelData.buttonType == QsMenuButtonType.CheckBox ? checkbox(modelData.checkState) : radio(modelData.checkState)
    onClicked: {
        if (modelData.hasChildren) {
            modelData.display(parent.window, parent.width + 20, 0);
        } else {
            modelData.triggered();
        }
    }
    hoverEnabled: true
    WrapperRectangle {
        extraMargin: 5
        radius: 5
        color: root.containsMouse ? Theme.bg3 : "transparent"
        RowLayout {
            Text {
                color: Theme.fg3
                text: button + modelData.text
            }

            IconImage {
                source: modelData.icon
                visible: source != ""
            }
        }
    }

    function checkbox(checkstate: Qt.CheckState): string {
        return checkstate == Qt.Unchecked ? "  " : "  ";
    }

    function radio(checkstate: bool): string {
        return checkstate ? "  " : "  ";
    }
}
