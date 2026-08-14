pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import qs.config

// Notification daemon.
//
// Only one process may own org.freedesktop.Notifications, so mako has to be
// stopped for this to bind (it is removed from the Hyprland autostart list as
// part of this change). If registration fails, Quickshell retries automatically
// once the current owner disappears.
Singleton {
    id: root

    readonly property alias server: notifServer

    // Newest first, capped for display.
    readonly property var visible: {
        const all = notifServer.trackedNotifications.values.slice();
        all.reverse();
        return all.slice(0, Settings.maxVisibleNotifications);
    }

    readonly property int count: notifServer.trackedNotifications.values.length

    function dismissAll(): void {
        // Copy first -- dismiss() mutates the model we would be iterating.
        for (const n of notifServer.trackedNotifications.values.slice())
            n.dismiss();
    }

    NotificationServer {
        id: notifServer

        // Advertise what the UI below can actually render, so senders degrade
        // gracefully instead of assuming support we do not have.
        keepOnReload: false
        bodySupported: true
        bodyMarkupSupported: true
        imageSupported: true
        actionsSupported: true
        actionIconsSupported: false
        inlineReplySupported: false
        persistenceSupported: true

        onNotification: notification => {
            // Without this the notification is dropped as soon as the signal
            // handler returns.
            notification.tracked = true;
        }
    }
}
