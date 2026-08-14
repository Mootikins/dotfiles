import QtQuick
import qs.config

// Nerd Font glyph. Split out from StyledText so the icon family can be swapped
// independently of the text family (e.g. text in a UI font, icons in Nerd).
Text {
    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: Colours.m3onSurface
    font.family: Settings.iconFamily
    font.pixelSize: Appearance.sizes.barIcon
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    Behavior on color {
        ColorAnimation {
            duration: Appearance.anim.durations.defaultEffects
        }
    }
}
