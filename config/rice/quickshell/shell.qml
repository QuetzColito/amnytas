//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
import Quickshell // for PanelWindow
import QtQuick // for Text
import qs.Bar
import qs.Windows

ShellRoot {

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Bar {
                screen: modelData
            }
        }
    }

    NotificationArea {}

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Background {
                screen: modelData
            }
        }
    }
}
