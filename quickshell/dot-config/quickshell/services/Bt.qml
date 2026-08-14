pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    // Distinguishes "no controller" (hide the icon, as waybar did) from
    // "controller present but off".
    readonly property bool hasAdapter: adapter !== null
    readonly property bool enabled: adapter?.enabled ?? false

    readonly property var connectedDevices: {
        const out = [];
        for (const d of (Bluetooth.devices?.values ?? []))
            if (d.connected)
                out.push(d);
        return out;
    }
    readonly property int connectedCount: connectedDevices.length

    readonly property string label: {
        if (!hasAdapter)
            return "No bluetooth controller";
        if (!enabled)
            return "Bluetooth off";
        if (connectedCount === 0)
            return "No devices connected";
        return connectedDevices.map(d => d.name).join(", ");
    }

    function toggle(): void {
        if (adapter)
            adapter.enabled = !adapter.enabled;
    }
}
