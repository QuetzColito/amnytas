import QtQuick.Layouts

GridLayout {
    columns: 2

    Clock {
        Layout.fillWidth: true
    }
    Buttons {
        Layout.rowSpan: 2
    }
    Calendar {}
    Calculator {
        Layout.columnSpan: 2
    }
    Timer {}
    Die {}
}
