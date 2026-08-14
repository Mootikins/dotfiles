pragma ComponentBehavior: Bound

import QtQuick
import qs.config
import qs.components

// One clickable status glyph in the bar. `tooltip` is surfaced by StatusIcons
// via the shared Tooltip popup rather than being drawn here.
Item {
    id: root

    property string icon: ""
    property string tooltip: ""
    property color iconColor: Colours.m3onSurfaceVariant
    property bool active: false

    signal activated
    signal secondaryActivated
    signal scrolled(int delta)

    readonly property alias hovered: layer.containsMouse

    implicitWidth: Appearance.sizes.barIcon + Appearance.padding.large
    implicitHeight: Settings.barPillHeight

    Icon {
        id: glyph

        anchors.centerIn: parent
        text: root.icon
        color: root.iconColor
    }

    StateLayer {
        id: layer

        radius: Appearance.rounding.small
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: event => {
            if (event.button === Qt.RightButton)
                root.secondaryActivated();
            else
                root.activated();
        }
    }

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

        onWheel: event => root.scrolled(event.angleDelta.y > 0 ? 1 : -1)
    }
}
