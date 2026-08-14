pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.config
import qs.components

// Clock. Click toggles between time and date, mirroring waybar's
// format / format-alt pair. The containing Island draws the pill.
Item {
    id: root

    property bool showDate: false

    readonly property string primary: Qt.formatDateTime(clock.date, "ddd HH:mm")
    readonly property string alt: Qt.formatDateTime(clock.date, "dd MMM") + Qt.formatDateTime(clock.date, " 'W'ww yyyy")

    implicitWidth: label.implicitWidth + Appearance.padding.large * 2
    implicitHeight: Settings.barPillHeight

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    StyledText {
        id: label

        anchors.centerIn: parent
        text: root.showDate ? root.alt : root.primary
        font.pixelSize: Appearance.font.size.normal
        color: Colours.m3onSurface
    }

    StateLayer {
        radius: Appearance.rounding.full

        onClicked: root.showDate = !root.showDate
    }
}
