//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1

import QtQuick
import Quickshell
import qs.config
import qs.modules.bar
import qs.modules.notifications
import qs.modules.launcher
import qs.modules.osd
import qs.modules.ipc

ShellRoot {
    id: root

    // One bar + one notification stack + one OSD per monitor.
    Variants {
        model: Quickshell.screens

        Scope {
            id: scope

            required property ShellScreen modelData

            readonly property bool excluded: Settings.excludedScreens.includes(scope.modelData.name)

            Bar {
                screen: scope.modelData
                active: !scope.excluded
            }

            NotificationPopups {
                screen: scope.modelData
            }

            Osd {
                screen: scope.modelData
            }
        }
    }

    // The launcher is global -- it opens on whichever screen has focus.
    Launcher {}

    // Keybind entry points (brightness, volume, notifications).
    ShellIpc {}
}
