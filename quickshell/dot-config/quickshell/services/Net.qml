pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

// Network state.
//
// Quickshell 0.3.0's Networking singleton exposes only `devices` (no top-level
// "active connection"), so the connected device and its access point are
// resolved by hand here. NetworkDevice.type is 1 for wifi on this box; wired
// devices have no `networks` model, which is the discriminator used below.
Singleton {
    id: root

    readonly property var devices: Networking.devices
    readonly property bool wifiEnabled: Networking.wifiEnabled

    readonly property var device: {
        const list = devices?.values ?? [];
        for (const d of list)
            if (d.connected)
                return d;
        return null;
    }

    // The access point we are associated with, if this is a wifi device.
    readonly property var accessPoint: {
        const aps = device?.networks?.values ?? [];
        for (const ap of aps)
            if (ap.connected)
                return ap;
        return null;
    }

    readonly property bool connected: device !== null
    readonly property bool isWifi: accessPoint !== null
    readonly property bool isEthernet: connected && !isWifi

    readonly property string ssid: accessPoint?.name ?? ""
    // 0..1 fraction.
    readonly property real strength: accessPoint?.signalStrength ?? 0
    readonly property int strengthPercent: Math.round(strength * 100)

    // 0-4, indexes the waybar-style signal ramp.
    readonly property int bars: {
        if (!isWifi)
            return 0;
        if (strength >= 0.8)
            return 4;
        if (strength >= 0.6)
            return 3;
        if (strength >= 0.4)
            return 2;
        if (strength >= 0.2)
            return 1;
        return 0;
    }

    readonly property string label: {
        if (isEthernet)
            return "Connected";
        if (isWifi)
            return `${ssid} (${strengthPercent}%)`;
        return "Disconnected";
    }
}
