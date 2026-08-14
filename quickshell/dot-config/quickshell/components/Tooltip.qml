pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.config

// Shared hover tooltip. One instance per bar; callers point `targetItem` at the
// hovered widget and set `text`.
//
// The anchor is the *window* plus a cached rect, never `anchor.item`. Binding
// anchor.item straight to the hovered widget crashes Quickshell: on hover-leave
// the item goes null inside the hover-event delivery, and the anchor update
// dereferences it (QQuickMouseArea::setHovered -> ... -> QQuickItem::window()).
// Caching the last known geometry keeps the anchor valid while the popup fades
// out, and survives the widget being destroyed entirely.
PopupWindow {
    id: root

    property Item targetItem: null
    property string text: ""
    // Vertical offset of the popup from the top of the anchor window.
    property real verticalOffset: Settings.barHeight

    readonly property bool shouldShow: targetItem !== null && text.length > 0

    // Cached anchor geometry, in window coordinates.
    property real cachedX: 0
    property real cachedWidth: 0

    function refreshGeometry(): void {
        if (!targetItem)
            return;
        const p = targetItem.mapToItem(null, 0, 0);
        cachedX = p.x;
        cachedWidth = targetItem.width;
    }

    onTargetItemChanged: {
        refreshGeometry();
        if (targetItem) {
            delay.triggered = false;
            delay.restart();
        }
    }

    visible: shouldShow && delay.triggered
    color: "transparent"

    implicitWidth: label.implicitWidth + Appearance.padding.large * 2
    implicitHeight: label.implicitHeight + Appearance.padding.normal * 2

    anchor {
        window: root.QsWindow.window
        rect.x: root.cachedX
        rect.y: root.verticalOffset
        rect.width: root.cachedWidth
        rect.height: 0
        // Attach to the bottom edge of the widget and grow downward; the
        // compositor centres the popup on that edge.
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: Appearance.padding.small
        // Keep the popup on screen for widgets near the display edge.
        adjustment: PopupAdjustment.SlideX | PopupAdjustment.FlipY
    }

    Timer {
        id: delay

        property bool triggered: false

        interval: 350
        running: root.shouldShow
        onTriggered: triggered = true
    }

    Rectangle {
        anchors.fill: parent
        radius: Appearance.rounding.small
        color: Colours.m3surfaceContainerHigh
        border.width: 1
        border.color: Colours.alpha(Colours.m3outlineVariant, 0.8)

        Text {
            id: label

            anchors.centerIn: parent
            text: root.text
            color: Colours.m3onSurface
            font.family: Settings.fontFamily
            font.pixelSize: Appearance.font.size.small
            renderType: Text.NativeRendering
        }
    }
}
