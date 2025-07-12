import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts // for Text
import "Bar"

Variants {
    model: Quickshell.screens

    delegate: Component {
        Bar {
            screen: modelData
        }
    }
}
