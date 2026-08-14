pragma Singleton

import QtQuick
import Quickshell

// Material 3 role names (the naming caelestia uses) mapped onto the Tokyo Night
// palette. Widgets should only ever reference m3* roles -- never raw hex --
// so the whole shell can be recoloured by editing this one file.
Singleton {
    id: root

    readonly property bool light: false

    // -- Surfaces ------------------------------------------------------------
    readonly property color m3background: "#1a1b26"
    readonly property color m3surface: "#1a1b26"
    readonly property color m3surfaceContainerLow: "#1f2335"
    readonly property color m3surfaceContainer: "#24283b"
    readonly property color m3surfaceContainerHigh: "#292e42"
    readonly property color m3surfaceContainerHighest: "#343b58"

    // -- Content -------------------------------------------------------------
    readonly property color m3onBackground: "#c0caf5"
    readonly property color m3onSurface: "#c0caf5"
    readonly property color m3onSurfaceVariant: "#9aa5ce"
    readonly property color m3outline: "#565f89"
    readonly property color m3outlineVariant: "#3b4261"

    // -- Accents -------------------------------------------------------------
    readonly property color m3primary: "#7aa2f7"
    readonly property color m3onPrimary: "#1a1b26"
    readonly property color m3primaryContainer: "#3d59a1"
    readonly property color m3onPrimaryContainer: "#c0caf5"

    readonly property color m3secondary: "#bb9af7"
    readonly property color m3onSecondary: "#1a1b26"
    readonly property color m3tertiary: "#7dcfff"
    readonly property color m3onTertiary: "#1a1b26"

    // -- Status --------------------------------------------------------------
    readonly property color m3error: "#f7768e"
    readonly property color m3onError: "#1a1b26"
    readonly property color m3warning: "#e0af68"
    readonly property color m3success: "#9ece6a"

    // Alpha helper -- `Colours.alpha(Colours.m3primary, 0.12)`.
    function alpha(c: color, a: real): color {
        return Qt.rgba(c.r, c.g, c.b, a);
    }
}
