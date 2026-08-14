pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.components
import qs.services

// Workspace switcher, caelestia-style: a capsule that springs between
// workspaces rather than a static highlight, with occupancy shown by weight
// instead of an extra glyph.
//
// Hyprland only keeps a workspace in its list while it exists (has windows or
// is focused), so "present in Hyprland.workspaces" is the occupancy test. The
// row is padded out to Settings.minWorkspaces so the layout does not jump.
Item {
    id: root

    readonly property int itemSize: 20
    readonly property int gap: Appearance.spacing.small
    // The active capsule is wider than a plain slot -- this is the overhang.
    readonly property int capsuleGrow: 10

    readonly property var occupied: {
        const set = {};
        for (const w of Hypr.workspaces.values)
            if (w.id > 0)
                set[w.id] = true;
        return set;
    }

    readonly property int count: {
        let max = Settings.minWorkspaces;
        for (const w of Hypr.workspaces.values)
            if (w.id > max)
                max = w.id;
        return max;
    }

    readonly property int activeId: Hypr.focusedWorkspace?.id ?? 1
    readonly property int activeIndex: activeId - 1
    readonly property bool activeVisible: activeIndex >= 0 && activeIndex < count

    implicitWidth: count * itemSize + (count - 1) * gap + capsuleGrow
    implicitHeight: itemSize

    // Sliding active capsule. Items are a fixed width, so the position is pure
    // arithmetic -- no mapToItem plumbing, and nothing to invalidate on resize.
    StyledRect {
        id: capsule

        width: root.itemSize + root.capsuleGrow
        height: root.itemSize
        radius: Appearance.rounding.full
        color: Colours.m3primary
        visible: root.activeVisible
        y: 0
        x: root.activeIndex * (root.itemSize + root.gap)

        Behavior on x {
            Anim {
                type: Anim.Spatial
            }
        }
    }

    Row {
        x: root.capsuleGrow / 2
        spacing: root.gap

        Repeater {
            model: root.count

            Item {
                id: item

                required property int index

                readonly property int wsId: index + 1
                readonly property bool isActive: wsId === root.activeId
                readonly property bool isOccupied: root.occupied[wsId] === true

                width: root.itemSize
                height: root.itemSize

                StyledText {
                    anchors.centerIn: parent
                    text: item.wsId
                    font.pixelSize: Appearance.font.size.small
                    font.bold: item.isActive
                    horizontalAlignment: Text.AlignHCenter
                    color: item.isActive ? Colours.m3onPrimary : item.isOccupied ? Colours.m3onSurface : Colours.alpha(Colours.m3outline, 0.7)
                }

                StateLayer {
                    radius: Appearance.rounding.full
                    layerColor: item.isActive ? Colours.m3onPrimary : Colours.m3onSurface

                    onClicked: Hypr.focusWorkspace(item.wsId)
                }
            }
        }
    }

    // Scroll anywhere on the group to cycle workspaces, as waybar did.
    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

        onWheel: event => {
            if (event.angleDelta.y < 0)
                Hypr.cycleWorkspace(1);
            else if (event.angleDelta.y > 0)
                Hypr.cycleWorkspace(-1);
        }
    }
}
