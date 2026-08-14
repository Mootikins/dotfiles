import QtQuick
import qs.config

Rectangle {
    color: "transparent"
    antialiasing: true

    Behavior on color {
        ColorAnimation {
            duration: Appearance.anim.durations.defaultEffects
        }
    }
}
