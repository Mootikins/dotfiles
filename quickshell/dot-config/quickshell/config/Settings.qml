pragma Singleton

import QtQuick
import Quickshell

// User-facing knobs. Everything here is safe to tweak without touching the
// widget code; the modules read these at runtime, so `qs reload` picks changes up.
Singleton {
    id: root

    // -- Fonts ---------------------------------------------------------------
    // NOTE: the old waybar style asked for "JetBrainsMono Nerd Font", which is
    // NOT installed on this machine (fontconfig silently fell back to Noto Sans
    // Mono + per-glyph nerd fallback). MesloLGS Nerd Font *is* installed, so it
    // is the default here. To go back to JetBrains: install ttf-jetbrains-mono-nerd
    // and set both families below to "JetBrainsMono Nerd Font".
    readonly property string fontFamily: "MesloLGS Nerd Font"
    readonly property string iconFamily: "MesloLGS Nerd Font"

    // -- Bar -----------------------------------------------------------------
    // Taller than the old 26px waybar so the pill-shaped module groups have
    // room to breathe, which is what makes the caelestia look work.
    readonly property int barHeight: 36
    // Height of the module islands inside the bar.
    readonly property int barPillHeight: 26
    // Screens the bar should be skipped on, matched against ShellScreen.name.
    readonly property var excludedScreens: []
    // Workspaces always shown even when empty (waybar's persistent-workspaces).
    readonly property int minWorkspaces: 5

    // -- Behaviour -----------------------------------------------------------
    readonly property int notificationTimeout: 5000
    readonly property int maxVisibleNotifications: 5
    readonly property int osdTimeout: 1500

    // -- Commands ------------------------------------------------------------
    // Kept identical to the waybar on-click actions so muscle memory survives.
    readonly property string terminal: "wezterm"
    readonly property string sysMonitor: "wezterm start -- btop"
    readonly property string wifiMenu: "wezterm start -- wifitui"
    readonly property string audioMixer: "pavucontrol"
    readonly property string bluetoothMenu: "blueman-manager"
}
