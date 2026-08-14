pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

// Hyprland helpers.
//
// IMPORTANT: this machine runs Hyprland 0.56.1 with a *Lua* config, where the
// IPC dispatcher expects Lua expressions rather than the classic string form.
// `dispatch("workspace 1")` fails with a Lua parse error; it has to be
// `dispatch('hl.dsp.focus({workspace = 1})')`. Every dispatch goes through the
// helpers below so that quirk lives in exactly one place.
Singleton {
    id: root

    // Active submap name; "" means the default map. Hyprland emits a `submap`
    // event on every change -- there is no property to poll for this.
    property string submap: ""

    readonly property var workspaces: Hyprland.workspaces
    readonly property var monitors: Hyprland.monitors
    readonly property var focusedWorkspace: Hyprland.focusedWorkspace
    readonly property var focusedMonitor: Hyprland.focusedMonitor

    function focusWorkspace(id: int): void {
        Hyprland.dispatch(`hl.dsp.focus({workspace = ${id}})`);
    }

    function cycleWorkspace(delta: int): void {
        Hyprland.dispatch(`hl.dsp.focus({workspace = "e${delta > 0 ? "+" : ""}${delta}"})`);
    }

    function resetSubmap(): void {
        Hyprland.dispatch('hl.dsp.submap("reset")');
    }

    Connections {
        target: Hyprland

        function onRawEvent(event): void {
            if (event.name === "submap")
                root.submap = event.data;
        }
    }

    // The submap event only fires on *change*, so a shell restart mid-submap
    // would show a stale value. Hyprland always starts in the default map and
    // we cannot query it, so assume default on load.
    Component.onCompleted: root.submap = ""
}
