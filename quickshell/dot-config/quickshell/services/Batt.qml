pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

// Battery state.
//
// NOTE: UPowerDevice.percentage is a 0..1 fraction here, not 0..100 (verified
// against `upower -i` reading 100% while the property read 1). `percent` below
// is the display value.
Singleton {
    id: root

    readonly property UPowerDevice device: UPower.displayDevice
    readonly property bool available: device?.ready === true && device?.isLaptopBattery === true

    readonly property real fraction: device?.percentage ?? 0
    readonly property int percent: Math.round(fraction * 100)

    readonly property int state: device?.state ?? UPowerDeviceState.Unknown
    readonly property bool charging: state === UPowerDeviceState.Charging
    readonly property bool full: state === UPowerDeviceState.FullyCharged
    readonly property bool discharging: state === UPowerDeviceState.Discharging

    // Watts. UPower reports this unsigned; the direction comes from `state`.
    readonly property real power: device?.changeRate ?? 0
    readonly property real timeToEmpty: device?.timeToEmpty ?? 0
    readonly property real timeToFull: device?.timeToFull ?? 0

    readonly property bool low: discharging && percent <= 20
    readonly property bool critical: discharging && percent <= 10

    function formatTime(seconds: real): string {
        if (seconds <= 0)
            return "";
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        return h > 0 ? `${h}h ${m}m` : `${m}m`;
    }
}
