pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import qs.config
import qs.components
import qs.services

// Notification stack, top-right under the bar -- roughly where mako put them.
PanelWindow {
    id: root

    visible: column.children.length > 0
    color: "transparent"
    exclusiveZone: 0

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:notifications"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    anchors {
        top: true
        right: true
    }

    margins.top: Appearance.padding.normal
    margins.right: Appearance.padding.normal

    implicitWidth: Appearance.sizes.notifWidth + Appearance.padding.normal * 2
    implicitHeight: Math.max(1, column.implicitHeight)

    Column {
        id: column

        anchors.top: parent.top
        anchors.right: parent.right
        spacing: Appearance.spacing.normal

        Repeater {
            model: Notifs.visible

            NotificationItem {
                id: item

                required property Notification modelData

                notification: item.modelData

                // Slide in from the right, fade out on removal.
                opacity: 0
                x: width

                Component.onCompleted: {
                    opacity = 1;
                    x = 0;
                }

                Behavior on opacity {
                    Anim {
                        type: Anim.FastEffects
                    }
                }

                Behavior on x {
                    Anim {
                        type: Anim.Spatial
                    }
                }
            }
        }
    }
}
