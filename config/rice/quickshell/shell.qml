//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma IconTheme TokyoNight-SE
import Quickshell // for PanelWindow
import QtQuick // for Text
import qs.Bar as Bar
import qs.Dashboard
import qs.Windows

ShellRoot {

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Background {
                screen: modelData
            }
        }
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Bar.Window {
                screen: modelData
            }
        }
    }

    Dashboard {}

    NotificationArea {}

    LockScreen {}

    Keyboard {}
}
