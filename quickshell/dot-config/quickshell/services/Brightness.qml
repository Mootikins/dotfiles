pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// Backlight control.
//
// Writes go through logind's SetBrightness D-Bus method rather than
// `brightnessctl`. On this machine the brightnessctl package ships no udev
// rules and is not setuid, and /sys/class/backlight/*/brightness is root:root
// 0644 -- so `brightnessctl set` fails with EPERM for a normal user. logind
// grants brightness control to whoever owns the active *seat* session, which
// needs no root and no udev rule.
//
// The target is resolved from the logind User.Display property instead of the
// convenient /session/self or /session/auto paths. Those resolve to the
// caller's own session, which is only the graphical one when the shell was
// started by the compositor; launched from a terminal (or an SSH session) they
// point at a seatless session and logind refuses with "Your session has no
// seat". Display always names the user's graphical session.
//
// Reads come straight from sysfs. The kernel does fire inotify events on those
// attributes, but FileView still hands back its cached copy at signal time, so
// onFileChanged has to reload() and the value is picked up in onLoaded.
Singleton {
    id: root

    readonly property string device: "intel_backlight"
    readonly property string basePath: `/sys/class/backlight/${device}`

    property int max: 1
    property int raw: 0
    property string sessionPath: ""

    readonly property real value: max > 0 ? raw / max : 0   // 0..1
    readonly property int percent: Math.round(value * 100)
    readonly property bool available: max > 1

    // Bumped whenever the backlight changes, so the OSD can react to any
    // source -- our own setter, the media keys, or anything else.
    property int revision: 0

    function setValue(v: real): void {
        if (!available)
            return;
        if (!sessionPath) {
            console.warn("Brightness: logind session not resolved yet, ignoring set");
            return;
        }
        const clamped = Math.max(0.01, Math.min(1, v));
        setProc.exec(["busctl", "call", "org.freedesktop.login1", sessionPath, "org.freedesktop.login1.Session", "SetBrightness", "ssu", "backlight", device, String(Math.round(clamped * max))]);
    }

    function changeValue(delta: real): void {
        setValue(value + delta);
    }

    // Resolve the graphical session's object path once at startup.
    Process {
        running: true
        // UID is resolved by the shell -- it is not reliably in the environment.
        command: ["sh", "-c", "busctl get-property org.freedesktop.login1 /org/freedesktop/login1/user/_$(id -u) org.freedesktop.login1.User Display"]

        stdout: StdioCollector {
            onStreamFinished: {
                // Output looks like: (so) "4" "/org/freedesktop/login1/session/_34"
                const m = text.match(/"([^"]*\/session\/[^"]+)"/);
                if (m)
                    root.sessionPath = m[1];
                else
                    console.warn("Brightness: could not resolve logind display session from:", text.trim());
            }
        }
    }

    Process {
        id: setProc

        onExited: (code, status) => {
            if (code !== 0)
                console.warn("Brightness: logind SetBrightness failed with exit code", code);
        }
    }

    FileView {
        path: `${root.basePath}/max_brightness`

        onLoaded: root.max = parseInt(text().trim(), 10) || 1
    }

    FileView {
        id: current

        path: `${root.basePath}/brightness`
        watchChanges: true

        onFileChanged: reload()
        onLoaded: {
            const v = parseInt(text().trim(), 10);
            if (!isNaN(v) && v !== root.raw) {
                root.raw = v;
                root.revision++;
            }
        }
    }
}
