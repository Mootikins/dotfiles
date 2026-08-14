import QtQuick
import qs.config
import qs.components

// A rounded module group. Caelestia's bar is built from these floating
// containers rather than one flat strip; grouping related widgets inside a
// pill is most of what gives it its look.
StyledRect {
    id: root

    default property alias content: inner.data

    implicitWidth: inner.childrenRect.width + Appearance.padding.normal * 2
    implicitHeight: Settings.barPillHeight

    radius: Appearance.rounding.full
    color: Colours.alpha(Colours.m3surfaceContainer, 0.75)

    Item {
        id: inner

        anchors.centerIn: parent
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}
