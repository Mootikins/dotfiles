pragma ComponentBehavior: Bound

import QtQuick
import qs.config

// Material 3 state layer: hover tint plus a press ripple originating at the
// cursor. A trimmed version of caelestia's StateLayer -- theirs draws the
// ripple with QtQuick.Shapes + CurveRenderer, this one clips a plain circle,
// which is cheaper and needs no plugin.
//
// Drop it inside any Item; it fills the parent and picks up its `radius`.
MouseArea {
    id: root

    property color layerColor: Colours.m3onSurface
    property real radius: parent?.radius ?? 0
    property bool disabled

    anchors.fill: parent
    enabled: !disabled
    hoverEnabled: true
    cursorShape: disabled ? Qt.ArrowCursor : Qt.PointingHandCursor

    onPressed: e => {
        ripple.x = e.x;
        ripple.y = e.y;
        rippleAnim.restart();
    }

    Item {
        anchors.fill: parent
        clip: true

        // Hover tint.
        Rectangle {
            anchors.fill: parent
            radius: root.radius
            color: root.layerColor
            opacity: root.containsMouse && !root.disabled ? 0.09 : 0

            Behavior on opacity {
                Anim {
                    type: Anim.FastEffects
                }
            }
        }

        // Press ripple.
        Rectangle {
            id: ripple

            property real size: 0

            width: size
            height: size
            x: 0
            y: 0
            transform: Translate {
                x: -ripple.size / 2
                y: -ripple.size / 2
            }
            radius: size / 2
            color: root.layerColor
            opacity: 0
        }

        SequentialAnimation {
            id: rippleAnim

            PropertyAction {
                target: ripple
                property: "opacity"
                value: 0.13
            }
            ParallelAnimation {
                Anim {
                    target: ripple
                    property: "size"
                    from: 0
                    to: Math.max(root.width, root.height) * 2.2
                    type: Anim.SlowEffects
                }
                Anim {
                    target: ripple
                    property: "opacity"
                    to: 0
                    type: Anim.SlowEffects
                }
            }
        }
    }
}
