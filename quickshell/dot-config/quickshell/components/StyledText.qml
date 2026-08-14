import QtQuick
import qs.config

Text {
    id: root

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: Colours.m3onSurface
    font.family: Settings.fontFamily
    font.pixelSize: Appearance.font.size.normal
    verticalAlignment: Text.AlignVCenter

    Behavior on color {
        ColorAnimation {
            duration: Appearance.anim.durations.defaultEffects
        }
    }
}
