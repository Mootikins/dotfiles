pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

// Default sink/source volume. PwObjectTracker is mandatory -- without it the
// node's `audio` sub-object is never bound and volume/muted read as undefined.
Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool ready: sink?.audio !== null && sink?.audio !== undefined
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property bool sourceMuted: source?.audio?.muted ?? false

    // 0..100, for display.
    readonly property int percent: Math.round(volume * 100)

    function setVolume(v: real): void {
        if (sink?.audio)
            sink.audio.volume = Math.max(0, Math.min(1, v));
    }

    function changeVolume(delta: real): void {
        setVolume(volume + delta);
    }

    function toggleMute(): void {
        if (sink?.audio)
            sink.audio.muted = !sink.audio.muted;
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
