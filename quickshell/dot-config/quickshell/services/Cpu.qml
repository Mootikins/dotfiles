pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// CPU + memory usage, sampled from /proc. The old waybar cpu module was a bare
// icon with no readout; this keeps the icon but gives the tooltip real numbers.
Singleton {
    id: root

    property real usage: 0        // 0..1
    property real memUsage: 0     // 0..1
    property real memUsedGb: 0
    property real memTotalGb: 0

    property var _prevTotal: 0
    property var _prevIdle: 0

    readonly property int percent: Math.round(usage * 100)
    readonly property int memPercent: Math.round(memUsage * 100)

    FileView {
        id: stat

        path: "/proc/stat"
    }

    FileView {
        id: meminfo

        path: "/proc/meminfo"
    }

    Timer {
        running: true
        interval: 3000
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            stat.reload();
            meminfo.reload();

            // First line of /proc/stat: aggregate jiffies across all cores.
            const line = stat.text().split("\n")[0] ?? "";
            const f = line.trim().split(/\s+/).slice(1).map(Number);
            if (f.length >= 4 && !f.some(isNaN)) {
                const idle = f[3] + (f[4] ?? 0);
                const total = f.reduce((a, b) => a + b, 0);
                const dTotal = total - root._prevTotal;
                const dIdle = idle - root._prevIdle;
                if (root._prevTotal > 0 && dTotal > 0)
                    root.usage = Math.max(0, Math.min(1, 1 - dIdle / dTotal));
                root._prevTotal = total;
                root._prevIdle = idle;
            }

            const mem = {};
            for (const l of meminfo.text().split("\n")) {
                const m = l.match(/^(\w+):\s+(\d+)/);
                if (m)
                    mem[m[1]] = parseInt(m[2], 10);
            }
            if (mem.MemTotal > 0) {
                const used = mem.MemTotal - (mem.MemAvailable ?? mem.MemFree ?? 0);
                root.memUsage = used / mem.MemTotal;
                root.memUsedGb = used / 1048576;
                root.memTotalGb = mem.MemTotal / 1048576;
            }
        }
    }
}
