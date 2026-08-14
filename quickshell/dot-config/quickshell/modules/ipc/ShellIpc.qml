import Quickshell
import Quickshell.Io
import qs.services

// IPC surface for keybinds: `qs ipc call <target> <function>`.
//
// Brightness is routed through here because plain `brightnessctl set` cannot
// work on this machine (no udev rule, not setuid, sysfs is root:root 0644).
// The Brightness service uses logind instead, which needs no elevation.
Scope {
    id: root

    IpcHandler {
        target: "brightness"

        function up(): void {
            Brightness.changeValue(0.05);
        }

        function down(): void {
            Brightness.changeValue(-0.05);
        }

        function set(percent: string): void {
            const v = parseFloat(percent);
            if (!isNaN(v))
                Brightness.setValue(v / 100);
        }

        function get(): string {
            return String(Brightness.percent);
        }
    }

    IpcHandler {
        target: "audio"

        function up(): void {
            Audio.changeVolume(0.05);
        }

        function down(): void {
            Audio.changeVolume(-0.05);
        }

        function mute(): void {
            Audio.toggleMute();
        }

        function get(): string {
            return String(Audio.percent);
        }
    }

    IpcHandler {
        target: "notifs"

        function clear(): void {
            Notifs.dismissAll();
        }

        function count(): string {
            return String(Notifs.count);
        }
    }
}
