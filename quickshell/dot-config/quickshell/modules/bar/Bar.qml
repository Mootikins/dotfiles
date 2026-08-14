pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components
import "components"

// Top bar.
//
// Same module set as the waybar config it replaces (workspaces, submap, clock,
// tray, bluetooth, network, volume, cpu, battery) but laid out the caelestia
// way: modules grouped into rounded "islands" floating on the bar surface,
// Material 3 state layers on every interactive element, and springy motion.
PanelWindow {
    id: root

    property bool active: true

    visible: active
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell:bar"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Settings.barHeight
    exclusiveZone: active ? Settings.barHeight : 0

    StyledRect {
        anchors.fill: parent
        color: Colours.m3background
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: Appearance.padding.normal
        anchors.rightMargin: Appearance.padding.normal

        // -- Left island ------------------------------------------------------
        RowLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: Appearance.spacing.normal

            Island {
                Workspaces {}
            }

            Submap {}
        }

        // -- Centre island ----------------------------------------------------
        // Anchored rather than laid out, so the clock stays centred on screen
        // no matter how wide the side groups grow.
        Island {
            anchors.centerIn: parent

            Clock {}
        }

        // -- Right island -----------------------------------------------------
        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: Appearance.spacing.normal

            Island {
                visible: tray.hasItems

                Tray {
                    id: tray
                }
            }

            Island {
                StatusIcons {
                    id: statusIcons
                }
            }
        }
    }

    Tooltip {
        targetItem: statusIcons.hoveredItem
        text: statusIcons.hoveredTooltip
        verticalOffset: Settings.barHeight - Appearance.padding.small
    }
}
