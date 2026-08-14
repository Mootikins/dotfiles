pragma Singleton

import QtQuick
import Quickshell

// Nerd Font glyphs, declared by codepoint rather than as literal characters.
//
// These all live in the Private Use Area, where they are easy to mangle by
// copy/paste or by an editor that re-encodes the file -- the previous waybar
// config had silently lost its bluetooth, volume and tray-expander glyphs to
// exactly that, leaving empty strings that rendered as nothing. Spelling them
// as codepoints keeps them greppable and impossible to corrupt invisibly.
//
// Every codepoint below was verified present in MesloLGS Nerd Font with
// `fc-list ":charset=<cp>"`.
Singleton {
    id: root

    function cp(code: int): string {
        return String.fromCodePoint(code);
    }

    // -- Workspaces / submap -------------------------------------------------
    readonly property string workspaceActive: cp(0xF14FB)  // md-square-rounded
    readonly property string submap: cp(0xF0A68)           // md-resize

    // -- Network (carried over from waybar) ----------------------------------
    readonly property list<string> wifi: [cp(0xF092F), cp(0xF091F), cp(0xF0922), cp(0xF0925), cp(0xF0928)]
    readonly property string ethernet: cp(0xF0002)
    readonly property string networkOff: cp(0xF092E)

    // -- Bluetooth -----------------------------------------------------------
    readonly property string bluetooth: cp(0xF00AF)
    readonly property string bluetoothConnected: cp(0xF00B1)
    readonly property string bluetoothOff: cp(0xF00B2)

    // -- Volume --------------------------------------------------------------
    readonly property string volumeMuted: cp(0xF0581)
    readonly property list<string> volume: [cp(0xF057F), cp(0xF0580), cp(0xF057E)]
    readonly property string micMuted: cp(0xF036D)

    // -- System --------------------------------------------------------------
    readonly property string cpu: cp(0xF035B)
    readonly property string chevron: cp(0xF0141)          // md-chevron-left
    readonly property string brightness: cp(0xF00DF)       // md-brightness-7

    // -- Battery -------------------------------------------------------------
    readonly property string batteryFull: cp(0xF0085)
    readonly property list<string> batteryCharging: [cp(0xF089C), cp(0xF0086), cp(0xF0087), cp(0xF0088), cp(0xF089D), cp(0xF0089), cp(0xF089E), cp(0xF008A), cp(0xF008B), cp(0xF0085)]
    readonly property list<string> battery: [cp(0xF007A), cp(0xF007B), cp(0xF007C), cp(0xF007D), cp(0xF007E), cp(0xF007F), cp(0xF0080), cp(0xF0081), cp(0xF0082), cp(0xF0079)]

    // -- Notifications / launcher --------------------------------------------
    readonly property string bell: cp(0xF009A)
    readonly property string close: cp(0xF0156)
    readonly property string search: cp(0xF0349)
    readonly property string appsFallback: cp(0xF1398)

    // Arrows used in battery tooltips.
    readonly property string arrowUp: "↑"
    readonly property string arrowDown: "↓"
}
