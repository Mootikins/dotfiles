pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.config
import qs.components

// System tray, collapsed behind a chevron like waybar's tray-expander drawer.
// The containing Island draws the pill.
Row {
    id: root

    property bool expanded: false

    readonly property bool hasItems: SystemTray.items.values.length > 0
    readonly property int itemSize: Settings.barPillHeight

    spacing: 0

    // Chevron toggle.
    Item {
        width: root.itemSize
        height: root.itemSize

        Icon {
            anchors.centerIn: parent
            text: Icons.chevron
            color: root.expanded ? Colours.m3primary : Colours.m3onSurfaceVariant
            // Points left when collapsed -- the drawer opens leftward.
            rotation: root.expanded ? 180 : 0

            Behavior on rotation {
                Anim {
                    type: Anim.Spatial
                }
            }
        }

        StateLayer {
            radius: Appearance.rounding.full

            onClicked: root.expanded = !root.expanded
        }
    }

    // Drawer.
    Item {
        clip: true
        height: root.itemSize
        width: root.expanded ? items.implicitWidth : 0
        opacity: root.expanded ? 1 : 0

        Behavior on width {
            Anim {
                type: Anim.Spatial
            }
        }

        Behavior on opacity {
            Anim {
                type: Anim.FastEffects
            }
        }

        Row {
            id: items

            anchors.right: parent.right
            spacing: 0

            Repeater {
                model: SystemTray.items

                Item {
                    id: entry

                    required property SystemTrayItem modelData

                    width: root.itemSize
                    height: root.itemSize

                    IconImage {
                        anchors.centerIn: parent
                        implicitSize: Appearance.sizes.trayIcon
                        source: entry.modelData.icon
                        asynchronous: true
                    }

                    StateLayer {
                        radius: Appearance.rounding.full
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                        onClicked: event => {
                            const item = entry.modelData;
                            if (event.button === Qt.LeftButton) {
                                // Items that only offer a menu ignore activate().
                                if (item.onlyMenu)
                                    item.display(entry, 0, entry.height);
                                else
                                    item.activate();
                            } else if (event.button === Qt.RightButton) {
                                item.display(entry, 0, entry.height);
                            } else {
                                item.secondaryActivate();
                            }
                        }
                    }
                }
            }
        }
    }
}
