import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.Theme
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.Components
import qs.Services

Item {
    id: root
    implicitHeight: scroll.height + tabs.height
    implicitWidth: Math.max(scroll.width, tabs.width)

    property var model: AudioService.sinks

    WrapperItem {
        id: tabs
        topMargin: 10
        bottomMargin: 10
        rightMargin: 15
        RowLayout {

            IconToggleButton {
                id: sinkTab
                name: "output"
                active: true
                text.text: "Outputs"
                activeColor: Theme.blue
                clickable.onClicked: root.setTab(sinkTab, AudioService.sinks)
            }
            IconToggleButton {
                id: appTab
                name: "music_note"
                text.text: "Apps"
                activeColor: Theme.blue
                clickable.onClicked: root.setTab(appTab, AudioService.applications)
            }
            IconToggleButton {
                id: inputTab
                name: "input"
                text.text: "Inputs"
                activeColor: Theme.blue
                clickable.onClicked: root.setTab(inputTab, AudioService.inputs)
            }
            IconToggleButton {
                id: recorderTab
                name: "mic"
                text.text: "Recorders"
                activeColor: Theme.blue
                clickable.onClicked: root.setTab(recorderTab, AudioService.recorders)
            }
        }
    }

    function setTab(tab: IconToggleButton, nodes: list<PwNode>): void {
        appTab.active = false;
        recorderTab.active = false;
        sinkTab.active = false;
        inputTab.active = false;
        tab.active = true;
        root.model = nodes;
    }

    ScrollView {
        id: scroll
        implicitHeight: Math.min(content.height, 500)
        implicitWidth: content.width + 15
        Behavior on implicitHeight {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 200
            }
        }
        anchors.top: tabs.bottom
        ScrollBar.vertical.contentItem: Rectangle {
            implicitWidth: 6
            radius: 7
            color: Theme.bg3
        }
        ColumnLayout {
            id: content
            spacing: 10
            Behavior on height {
                NumberAnimation {
                    duration: 1000
                }
            }
            Repeater {
                model: root.model

                delegate: Rectangle {
                    id: entry
                    required property PwNode modelData
                    property string displayName: modelData.properties?.media?.name || modelData.nickname || modelData.description || modelData.name
                    height: grid.height + 20
                    width: grid.width + 15
                    border.width: 2
                    border.color: Theme.purple
                    radius: 7
                    color: "transparent"
                    GridLayout {
                        id: grid
                        height: entry.modelData.audio ? 70 : 35
                        width: 350
                        anchors.centerIn: parent
                        columns: 2
                        Text {
                            id: name
                            Layout.maximumWidth: 300
                            Layout.fillWidth: true

                            elide: Qt.ElideRight
                            color: Theme.fg
                            text: entry.displayName
                        }
                        IconToggleButton {
                            id: prefer
                            opacity: !entry.modelData.isStream ? 1 : 0
                            active: modelData == AudioService.preferredSink || modelData == AudioService.preferredSource
                            clickable.onClicked: modelData.isSink ? AudioService.setPreferredSink(modelData) : AudioService.setPreferredSource(modelData)
                            border.width: 0
                            activeColor: Theme.purple
                            name: "star"
                        }
                        StyledSlider {
                            id: slider
                            Layout.fillWidth: true
                            value: entry.modelData.audio?.volume || 0
                            visible: entry.modelData.audio
                            fillColor: Theme.purple
                            onMoved: entry.modelData.audio.volume = value
                        }
                        IconToggleButton {
                            id: mute
                            visible: entry.modelData.audio
                            active: entry.modelData.audio?.muted || false
                            clickable.onClicked: modelData.audio.muted = !modelData.audio?.muted
                            border.width: 0
                            activeColor: Theme.purple
                            name: "volume_off"
                            altName: "volume"
                        }
                    }
                }
            }
        }
    }
}
