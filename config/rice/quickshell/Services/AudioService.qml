pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode defaultSink: Pipewire.defaultAudioSink
    readonly property PwNode defaultSource: Pipewire.defaultAudioSource

    readonly property PwNode preferredSink: Pipewire.preferredDefaultAudioSink
    readonly property PwNode preferredSource: Pipewire.preferredDefaultAudioSource

    function insertDevice(nodes: var, node: PwNode, preferred: PwNode, index: int): int {
        if (node == preferred)
            nodes.unshift(node);
        else {
            if (!node.audio)
                nodes.push(node);
            else {
                nodes.splice(index, 0, node);
                index++;
            }
        }
        return index;
    }

    readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
        if (node.isStream) {
            if (node.isSink)
                acc.applications.push(node);
            else
                acc.recorders.push(node);
        } else {
            if (node.isSink)
                acc.AudioSinkIndex = insertDevice(acc.outputs, node, preferredSink, acc.AudioSinkIndex);
            else
                acc.AudioSourceIndex = insertDevice(acc.inputs, node, preferredSource, acc.AudioSourceIndex);
        }
        return acc;
    }, {
        applications: [],
        recorders: [],
        inputs: [],
        AudioSinkIndex: 0,
        outputs: [],
        AudioSourceIndex: 0
    })

    readonly property list<PwNode> applications: nodes.applications
    readonly property list<PwNode> recorders: nodes.recorders

    readonly property list<PwNode> inputs: nodes.inputs
    readonly property list<PwNode> sinks: nodes.outputs

    readonly property bool muted: defaultSink?.audio?.muted ?? false
    readonly property real volume: Math.round((defaultSink?.audio?.volume ?? 0) * 100)

    function setVolume(volume: real): void {
        if (defaultSink?.ready && defaultSink?.audio) {
            defaultSink.audio.muted = false;
            defaultSink.audio.volume = volume;
        }
    }

    function toggleMute(): void {
        if (defaultSink?.ready && defaultSink?.audio) {
            defaultSink.audio.muted = !muted;
        }
    }

    function increaseVolume(): void {
        setVolume((volume + 5) / 100);
    }

    function decreaseVolume(): void {
        setVolume((volume - 5) / 100);
    }

    function setPreferredSink(sink: PwNode): void {
        Pipewire.preferredDefaultAudioSink = sink;
    }

    function setPreferredSource(source: PwNode): void {
        Pipewire.preferredDefaultAudioSource = source;
    }

    PwObjectTracker {
        objects: [...root.inputs, ...root.sinks, ...root.applications, ...root.recorders]
    }
}
