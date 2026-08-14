pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.config
import qs.components
import qs.services

// Bluetooth / network / volume / cpu / battery. The containing Island draws
// the pill; this just lays the icons out and reports which one is hovered.
Item {
    id: root

    // Whichever child the pointer is over, or null.
    //
    // Every child's `hovered` is read on each pass -- deliberately no early
    // return. A QML binding only depends on the properties it actually reads,
    // so bailing out early would leave the binding blind to hover changes on
    // the children after the match.
    readonly property Item hoveredItem: {
        let found = null;
        for (let i = 0; i < layout.children.length; i++) {
            const c = layout.children[i];
            const isHovered = c.visible === true && c.hovered === true;
            if (isHovered && !found)
                found = c;
        }
        return found;
    }

    readonly property string hoveredTooltip: hoveredItem?.tooltip ?? ""

    implicitWidth: layout.implicitWidth
    implicitHeight: Settings.barPillHeight

    Row {
        id: layout

        anchors.centerIn: parent
        spacing: 0

        // -- Bluetooth -------------------------------------------------------
        BarIcon {
            visible: Bt.hasAdapter
            icon: !Bt.enabled ? Icons.bluetoothOff : Bt.connectedCount > 0 ? Icons.bluetoothConnected : Icons.bluetooth
            iconColor: Bt.connectedCount > 0 ? Colours.m3primary : Colours.m3onSurfaceVariant
            tooltip: Bt.label

            onActivated: Quickshell.execDetached(["sh", "-c", Settings.bluetoothMenu])
            onSecondaryActivated: Bt.toggle()
        }

        // -- Network ---------------------------------------------------------
        BarIcon {
            icon: Net.isEthernet ? Icons.ethernet : Net.isWifi ? Icons.wifi[Net.bars] : Icons.networkOff
            iconColor: Net.connected ? Colours.m3onSurfaceVariant : Colours.m3error
            tooltip: Net.label

            onActivated: Quickshell.execDetached(["sh", "-c", Settings.wifiMenu])
        }

        // -- Volume ----------------------------------------------------------
        BarIcon {
            icon: {
                if (Audio.muted || Audio.volume <= 0)
                    return Icons.volumeMuted;
                if (Audio.volume < 0.34)
                    return Icons.volume[0];
                if (Audio.volume < 0.67)
                    return Icons.volume[1];
                return Icons.volume[2];
            }
            iconColor: Audio.muted ? Colours.m3error : Colours.m3onSurfaceVariant
            tooltip: Audio.muted ? "Muted" : `Playing at ${Audio.percent}%`

            onActivated: Quickshell.execDetached(["sh", "-c", Settings.audioMixer])
            onSecondaryActivated: Audio.toggleMute()
            onScrolled: delta => Audio.changeVolume(delta * 0.05)
        }

        // -- CPU -------------------------------------------------------------
        BarIcon {
            icon: Icons.cpu
            iconColor: Cpu.usage > 0.85 ? Colours.m3error : Cpu.usage > 0.6 ? Colours.m3warning : Colours.m3onSurfaceVariant
            tooltip: `CPU ${Cpu.percent}%   RAM ${Cpu.memPercent}% (${Cpu.memUsedGb.toFixed(1)}/${Cpu.memTotalGb.toFixed(1)} GiB)`

            onActivated: Quickshell.execDetached(["sh", "-c", Settings.sysMonitor])
        }

        // -- Battery ---------------------------------------------------------
        Item {
            visible: Batt.available
            implicitWidth: visible ? battRow.implicitWidth + Appearance.padding.normal : 0
            implicitHeight: Settings.barPillHeight

            // Mirrors BarIcon's interface so the tooltip scan above works.
            readonly property alias hovered: battLayer.containsMouse
            readonly property string tooltip: {
                if (Batt.full)
                    return "Fully charged";
                const dir = Batt.charging ? Icons.arrowUp : Icons.arrowDown;
                const t = Batt.charging ? Batt.timeToFull : Batt.timeToEmpty;
                const eta = Batt.formatTime(t);
                return `${Batt.power.toFixed(1)}W${dir} ${Batt.percent}%${eta ? "  ·  " + eta : ""}`;
            }

            Row {
                id: battRow

                anchors.centerIn: parent
                spacing: Appearance.spacing.small

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    text: {
                        if (Batt.full)
                            return Icons.batteryFull;
                        const idx = Math.max(0, Math.min(9, Math.floor(Batt.percent / 10)));
                        return Batt.charging ? Icons.batteryCharging[idx] : Icons.battery[idx];
                    }
                    color: Batt.critical ? Colours.m3error : Batt.low ? Colours.m3warning : Batt.charging ? Colours.m3success : Colours.m3onSurfaceVariant
                }

                // waybar showed the percentage only while discharging.
                StyledText {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: Batt.discharging
                    text: `${Batt.percent}%`
                    font.pixelSize: Appearance.font.size.small
                    color: Batt.critical ? Colours.m3error : Batt.low ? Colours.m3warning : Colours.m3onSurfaceVariant
                }
            }

            StateLayer {
                id: battLayer

                radius: Appearance.rounding.small
            }
        }
    }
}
