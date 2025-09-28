pragma ComponentBehavior: Bound
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Theme
import qs.Components

Item {
    id: wrapper
    implicitWidth: root.width
    implicitHeight: root.height

    GridLayout {
        id: root
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

    Clickable {
        property int dragStartY: 0
        property int dragStartX: 0
        cursorShape: Qt.ArrowCursor
        onWheel: e => e.angleDelta.y > 0 ? root.decreaseMonth() : root.increaseMonth()
        onPressed: e => {
            dragStartY = e.y;
            dragStartX = e.x;
        }
        onReleased: e => {
            let xdiff = Math.abs(dragStartX - e.x);
            let ydiff = Math.abs(dragStartY - e.y);
            if (ydiff > xdiff)
                dragStartY >= e.y ? root.increaseMonth() : root.decreaseMonth();
            else
                dragStartX >= e.x ? root.decreaseMonth() : root.increaseMonth();
        }
    }
}
