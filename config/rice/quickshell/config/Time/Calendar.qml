import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:Theme"
import "root:Components"

WrapperMouseArea {
    onWheel: e => e.angleDelta.y > 0 ? decreaseMonth() : increaseMonth()
    GridLayout {
        columns: 2

        CenteredText {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            text: grid.locale.monthName(grid.month) + " " + grid.year
            color: Theme.blue
        }

        TextButton {
            text.text: " "
            Layout.fillWidth: true
            text.font.pointSize: 15
            onClicked: {
                grid.month = clock.date.getMonth();
                grid.year = clock.date.getFullYear();
            }
        }

        DayOfWeekRow {
            locale: grid.locale

            // Layout.column: 1
            Layout.fillWidth: true
            delegate: CenteredText {
                text: shortName
                color: Theme.purple

                required property string shortName
            }
        }

        WeekNumberColumn {
            month: grid.month
            year: grid.year
            locale: grid.locale

            Layout.fillHeight: true
            delegate: CenteredText {
                text: weekNumber
                color: Theme.purple

                required property int weekNumber
            }
        }

        MonthGrid {
            id: grid
            month: clock.date.getMonth()
            year: clock.date.getFullYear()
            locale: Qt.locale("de_DE")

            Layout.fillWidth: true
            Layout.fillHeight: true
            delegate: CenteredText {
                color: model.today ? Theme.orange : model.month === grid.month ? Theme.blue : Theme.fg3
                text: model.day

                required property var model
            }
        }
        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
    }

    function increaseMonth(): void {
        grid.month = (grid.month + 1) % 12;
        if (grid.month === 0)
            grid.year++;
    }

    function decreaseMonth(): void {
        if (grid.month === 0)
            grid.year--;
        grid.month = (grid.month + 11) % 12;
    }
}
