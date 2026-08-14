pragma ComponentBehavior: Bound

import QtQuick
import qs.config
import qs.components
import qs.services

// Active Hyprland submap badge (e.g. the "resize" modal). Hidden in the default
// map. Clicking it escapes back to the default map -- handy insurance, since a
// stuck submap swallows every keypress.
Item {
    id: root

    readonly property bool shown: Hypr.submap.length > 0

    implicitWidth: shown ? badge.implicitWidth : 0
    implicitHeight: Settings.barPillHeight
    clip: true
    opacity: shown ? 1 : 0

    Behavior on implicitWidth {
        Anim {
            type: Anim.Spatial
        }
    }

    Behavior on opacity {
        Anim {
            type: Anim.FastEffects
        }
    }

    StyledRect {
        id: badge

        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: label.implicitWidth + Appearance.padding.large * 2
        implicitHeight: root.implicitHeight
        radius: Appearance.rounding.full
        color: Colours.m3error

        StyledText {
            id: label

            anchors.centerIn: parent
            text: `${Icons.submap} ${Hypr.submap}`
            color: Colours.m3onError
            font.pixelSize: Appearance.font.size.small
            font.bold: true
        }

        StateLayer {
            radius: parent.radius
            layerColor: Colours.m3onError

            onClicked: Hypr.resetSubmap()
        }
    }
}
