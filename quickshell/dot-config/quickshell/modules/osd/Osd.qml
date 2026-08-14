pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components
import qs.services

// Volume / brightness on-screen display. There was no OSD under waybar, so the
// media and brightness keys gave no feedback at all.
//
// It listens to the underlying services rather than to keybinds, so it also
// fires for changes made from pavucontrol, another shell, or the lid sensor.
PanelWindow {
    id: root

    property bool shown: false
    property string mode: "volume"
    // Suppresses the burst of change signals emitted while services populate
    // at startup, which would otherwise flash the OSD on login.
    property bool armed: false

    readonly property real level: mode === "volume" ? (Audio.muted ? 0 : Audio.volume) : Brightness.value
    readonly property int percent: mode === "volume" ? (Audio.muted ? 0 : Audio.percent) : Brightness.percent

    readonly property string icon: {
        if (mode === "brightness")
            return Icons.brightness;
        if (Audio.muted || Audio.volume <= 0)
            return Icons.volumeMuted;
        if (Audio.volume < 0.34)
            return Icons.volume[0];
        if (Audio.volume < 0.67)
            return Icons.volume[1];
        return Icons.volume[2];
    }

    function show(which: string): void {
        if (!armed)
            return;
        mode = which;
        shown = true;
        hideTimer.restart();
    }

    visible: shown
    color: "transparent"
    exclusiveZone: 0

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:osd"
    // Never steal keyboard focus -- the OSD is passive feedback.
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    anchors.bottom: true
    margins.bottom: 120

    implicitWidth: Appearance.sizes.osdWidth
    implicitHeight: 56

    Timer {
        id: hideTimer

        interval: Settings.osdTimeout
        onTriggered: root.shown = false
    }

    Timer {
        running: true
        interval: 1500
        onTriggered: root.armed = true
    }

    Connections {
        target: Audio

        function onVolumeChanged(): void {
            root.show("volume");
        }

        function onMutedChanged(): void {
            root.show("volume");
        }
    }

    Connections {
        target: Brightness

        function onRevisionChanged(): void {
            root.show("brightness");
        }
    }

    StyledRect {
        id: card

        anchors.fill: parent
        radius: Appearance.rounding.large
        color: Colours.m3surfaceContainer
        border.width: 1
        border.color: Colours.alpha(Colours.m3outlineVariant, 0.7)

        opacity: root.shown ? 1 : 0
        scale: root.shown ? 1 : 0.92

        Behavior on opacity {
            Anim {
                type: Anim.FastEffects
            }
        }

        Behavior on scale {
            Anim {
                type: Anim.Spatial
            }
        }

        Row {
            anchors.fill: parent
            anchors.margins: Appearance.padding.larger
            spacing: Appearance.spacing.large

            Icon {
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                font.pixelSize: Appearance.font.size.larger
                color: Colours.m3primary
                width: 24
            }

            // Track + fill.
            Item {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 24 - 46 - Appearance.spacing.large * 2
                height: 6

                StyledRect {
                    anchors.fill: parent
                    radius: Appearance.rounding.full
                    color: Colours.alpha(Colours.m3onSurfaceVariant, 0.25)
                }

                StyledRect {
                    width: parent.width * Math.max(0, Math.min(1, root.level))
                    height: parent.height
                    radius: Appearance.rounding.full
                    color: Colours.m3primary

                    Behavior on width {
                        Anim {
                            type: Anim.FastEffects
                        }
                    }
                }
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                width: 46
                horizontalAlignment: Text.AlignRight
                text: `${root.percent}%`
                font.pixelSize: Appearance.font.size.normal
                color: Colours.m3onSurface
            }
        }
    }
}
