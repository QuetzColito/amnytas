import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Theme
import qs.Components

WrapperMouseArea {
    id: root
    property QsMenuHandle modelData: parent.modelData
    property string button: modelData.buttonType == QsMenuButtonType.None ? "" : modelData.buttonType == QsMenuButtonType.CheckBox ? checkbox(modelData.checkState) : radio(modelData.checkState)
    cursorShape: Qt.PointingHandCursor
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
            TextButton {
                implicitWidth: 15
                visible: button != ""
                text.text: button
                text.font.pointSize: Theme.textsize
            }

            Text {
                color: Theme.fg3
                text: root.modelData.text
            }

            IconImage {
                source: root.modelData.icon
                visible: source != ""
            }
        }
    }

    function checkbox(checkstate: var): string {
        return checkstate == Qt.Unchecked ? "" : "";
    }

    function radio(checkstate: var): string {
        return checkstate ? "" : "";
    }
}
