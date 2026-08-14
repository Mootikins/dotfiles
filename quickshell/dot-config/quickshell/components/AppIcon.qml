pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.config

// An application icon that degrades gracefully.
//
// Plenty of desktop entries name an icon the active theme does not ship
// (nm-connection-editor and the avahi tools, here). Handing those straight to
// IconImage renders Qt's magenta "missing image" checkerboard, so the name is
// checked first and a lettered tile is drawn instead.
Item {
    id: root

    property string icon: ""
    property string name: ""
    property int size: 26

    // "" when the icon is missing from the theme.
    readonly property string resolved: icon ? Quickshell.iconPath(icon, true) : ""

    implicitWidth: size
    implicitHeight: size

    IconImage {
        anchors.centerIn: parent
        visible: root.resolved !== ""
        implicitSize: root.size
        source: root.resolved
        asynchronous: true
    }

    Rectangle {
        anchors.centerIn: parent
        visible: root.resolved === ""
        width: root.size
        height: root.size
        radius: Appearance.rounding.small
        color: Colours.alpha(Colours.m3primary, 0.18)

        Text {
            anchors.centerIn: parent
            text: (root.name || "?").charAt(0).toUpperCase()
            color: Colours.m3primary
            font.family: Settings.fontFamily
            font.pixelSize: Math.round(root.size * 0.55)
            font.bold: true
            renderType: Text.NativeRendering
        }
    }
}
