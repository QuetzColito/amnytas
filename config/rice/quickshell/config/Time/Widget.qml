import QtQuick.Layouts
import Quickshell.Widgets

WrapperItem {
    extraMargin: 10

    GridLayout {
        columns: 2
        rowSpacing: 10
        columnSpacing: 10

        Clock {
            Layout.fillWidth: true
        }
        Buttons {
            Layout.rowSpan: 3
        }
        Calendar {}
        Calculator {}
        Timer {}
        Die {}
    }
}
