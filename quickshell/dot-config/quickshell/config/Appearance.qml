pragma Singleton

import QtQuick
import Quickshell

// Design tokens. This is the pure-QML stand-in for caelestia's `Tokens` type
// (which lives in their C++ `Caelestia.Config` plugin and so isn't importable
// here). Same idea: sizes, spacing, rounding, type scale and the Material 3
// Expressive motion set, all in one place.
Singleton {
    id: root

    // -- Spacing / sizing ----------------------------------------------------
    readonly property QtObject padding: QtObject {
        readonly property int smaller: 2
        readonly property int small: 4
        readonly property int normal: 8
        readonly property int large: 12
        readonly property int larger: 16
    }

    readonly property QtObject spacing: QtObject {
        readonly property int small: 4
        readonly property int normal: 8
        readonly property int large: 14
        readonly property int larger: 20
    }

    readonly property QtObject rounding: QtObject {
        readonly property int small: 6
        readonly property int normal: 10
        readonly property int large: 16
        readonly property int full: 1000
    }

    readonly property QtObject sizes: QtObject {
        readonly property int barIcon: 15
        readonly property int trayIcon: 14
        readonly property int notifWidth: 380
        readonly property int notifIcon: 36
        readonly property int launcherWidth: 560
        readonly property int launcherHeight: 420
        readonly property int launcherItem: 46
        readonly property int osdWidth: 240
    }

    // -- Type scale ----------------------------------------------------------
    readonly property QtObject font: QtObject {
        readonly property QtObject size: QtObject {
            readonly property int small: 11
            readonly property int normal: 12
            readonly property int large: 14
            readonly property int larger: 17
        }
    }

    // -- Motion (Material 3 Expressive) --------------------------------------
    readonly property QtObject anim: QtObject {
        readonly property QtObject durations: QtObject {
            readonly property int small: 150
            readonly property int normal: 250
            readonly property int large: 400
            readonly property int extraLarge: 550
            readonly property int fastEffects: 150
            readonly property int defaultEffects: 200
            readonly property int slowEffects: 300
            readonly property int fastSpatial: 350
            readonly property int defaultSpatial: 450
            readonly property int slowSpatial: 600
        }

        // QML bezier curves are [c1x, c1y, c2x, c2y, 1, 1].
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> emphasized: [0.05, 0, 0.13, 1, 1, 1]
        // Overshooting curves -- these give caelestia its springy feel.
        readonly property list<real> expressiveSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
        readonly property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
    }
}
