import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Theme

PopupWindow {
    id: popup
    property QsMenuOpener opener: menuoo

    QsMenuOpener {
        id: menuoo
    }

    anchor.rect.x: 10 - layout.width / 2
    anchor.rect.y: 25
    implicitWidth: Math.max(100, layout.width)
    implicitHeight: Math.max(100, layout.height)
    color: "transparent"
    WrapperRectangle {
        id: layout
        extraMargin: 10
        leftMargin: 5
        rightMargin: 5
        radius: 15
        color: `#${Colors.base01}`
        ColumnLayout {
            Repeater {
                model: menuoo.children
                Loader {
                    Layout.fillWidth: true
                    required property QsMenuHandle modelData
                    property var window: popup
                    source: modelData.isSeparator ? "Separator.qml" : "MenuItem.qml"
                }
            }
        }
    }
}
