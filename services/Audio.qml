pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: audio

    property bool ready: Pipewire.ready

    property PwNode defaultOutput: Pipewire.defaultAudioSink
    property PwNode defaultInput: Pipewire.defaultAudioSource
    readonly property var outputList: Pipewire.nodes.values.filter(n => n.type === PwNodeType.AudioSink && !n.isStream)
    readonly property var inputList: Pipewire.nodes.values.filter(n => n.type === PwNodeType.AudioSource && !n.isStream)

    function setDefaultOutput(node: PwNode) {
        if (node)
            Pipewire.preferredDefaultAudioSink = node;
    }

    function setDefaultInput(node: PwNode) {
        if (node)
            Pipewire.preferredDefaultAudioSource = node;
    }

    // Might not need this
    function changeOutputVolume(volume: real) {
        if (defaultOutput?.ready && defaultOutput?.audio) {
            defaultOutput.audio.muted = false;
            defaultOutput.audio.volume = Math.max(0, Math.min(1, defaultOutput.audio.volume + volume));
        }
    }

    function toggleOutputMute() {
        if (defaultOutput?.ready && defaultOutput?.audio)
            defaultOutput.audio.muted = !defaultOutput.audio.muted;
    }

    // This also might not be needed
    function changeInputVolume(volume: real) {
        if (defaultInput?.ready && defaultInput?.audio) {
            defaultInput.audio.muted = false;
            defaultInput.audio.volume = Math.max(0, Math.min(1, defaultInput.audio.volume + volume));
        }
    }

    function toggleInputMute() {
        if (defaultInput?.ready && defaultInput?.audio)
            defaultInput.audio.muted = !defaultInput.audio.muted;
    }

    PwObjectTracker {
        objects: [audio.defaultOutput, audio.defaultInput, ...audio.outputList, ...audio.inputList]
    }
}
