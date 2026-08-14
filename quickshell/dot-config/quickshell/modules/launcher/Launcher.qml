pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.config
import qs.components
import qs.services

// Application launcher, replacing wofi on Super+Space.
//
// Toggled over Quickshell IPC (`qs ipc call launcher toggle`) rather than the
// Wayland global-shortcut protocol, because the Hyprland config here is Lua and
// exec_cmd is the binding form already known to work.
Scope {
    id: root

    property bool open: false

    function toggle(): void {
        open = !open;
    }

    function show(): void {
        open = true;
    }

    function hide(): void {
        open = false;
    }

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            root.toggle();
        }

        function open(): void {
            root.show();
        }

        function close(): void {
            root.hide();
        }
    }

    PanelWindow {
        id: window

        visible: root.open
        color: "transparent"
        exclusiveZone: 0

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell:launcher"
        // Exclusive so the search field receives keystrokes while open.
        WlrLayershell.keyboardFocus: root.open ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        // Gated on `open` so the list builds no delegates -- and requests no
        // icons -- while the launcher is hidden.
        readonly property var results: root.open ? Apps.search(input.text, 50) : []
        property int selected: 0

        onResultsChanged: selected = 0

        function launch(index: int): void {
            const entry = results[index];
            if (!entry)
                return;
            root.hide();
            entry.execute();
        }

        // Reset state each time it opens.
        onVisibleChanged: {
            if (visible) {
                input.text = "";
                selected = 0;
                input.forceActiveFocus();
            }
        }

        // Scrim -- click anywhere outside the panel to dismiss.
        Rectangle {
            anchors.fill: parent
            color: Colours.alpha(Colours.m3background, 0.45)

            MouseArea {
                anchors.fill: parent
                onClicked: root.hide()
            }
        }

        StyledRect {
            id: panel

            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height / 5

            implicitWidth: Appearance.sizes.launcherWidth
            implicitHeight: Math.min(Appearance.sizes.launcherHeight, searchRow.implicitHeight + Appearance.padding.larger * 2 + list.contentHeight + (list.count > 0 ? Appearance.padding.normal : 0))

            radius: Appearance.rounding.large
            color: Colours.m3surfaceContainerLow
            border.width: 1
            border.color: Colours.alpha(Colours.m3outlineVariant, 0.9)

            opacity: root.open ? 1 : 0
            scale: root.open ? 1 : 0.96

            Behavior on opacity {
                Anim {
                    type: Anim.FastEffects
                }
            }

            Behavior on scale {
                Anim {
                    type: Anim.Spatial
                }
            }

            // Swallow scrim clicks that land on the panel itself.
            MouseArea {
                anchors.fill: parent
            }

            Item {
                id: searchRow

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Appearance.padding.larger
                implicitHeight: 32

                Icon {
                    id: searchIcon

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: Icons.search
                    color: Colours.m3onSurfaceVariant
                    font.pixelSize: Appearance.font.size.large
                }

                TextInput {
                    id: input

                    anchors.left: searchIcon.right
                    anchors.leftMargin: Appearance.spacing.normal
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    color: Colours.m3onSurface
                    font.family: Settings.fontFamily
                    font.pixelSize: Appearance.font.size.large
                    selectionColor: Colours.alpha(Colours.m3primary, 0.4)
                    selectedTextColor: Colours.m3onSurface
                    clip: true
                    focus: true

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: input.text.length === 0
                        text: "Search applications"
                        color: Colours.m3outline
                        font: input.font
                        renderType: Text.NativeRendering
                    }

                    Keys.onEscapePressed: root.hide()
                    Keys.onReturnPressed: window.launch(window.selected)
                    Keys.onEnterPressed: window.launch(window.selected)

                    Keys.onDownPressed: {
                        if (window.results.length > 0)
                            window.selected = (window.selected + 1) % window.results.length;
                    }
                    Keys.onUpPressed: {
                        if (window.results.length > 0)
                            window.selected = (window.selected - 1 + window.results.length) % window.results.length;
                    }
                    Keys.onTabPressed: {
                        if (window.results.length > 0)
                            window.selected = (window.selected + 1) % window.results.length;
                    }
                }
            }

            StyledRect {
                id: divider

                anchors.top: searchRow.bottom
                anchors.topMargin: Appearance.padding.normal
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                visible: list.count > 0
                color: Colours.alpha(Colours.m3outlineVariant, 0.7)
            }

            ListView {
                id: list

                anchors.top: divider.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: Appearance.padding.small
                anchors.topMargin: Appearance.padding.small

                clip: true
                model: window.results
                currentIndex: window.selected
                highlightMoveDuration: Appearance.anim.durations.fastEffects
                // Keep the keyboard selection scrolled into view.
                highlightRangeMode: ListView.ApplyRange
                preferredHighlightBegin: Appearance.sizes.launcherItem
                preferredHighlightEnd: height - Appearance.sizes.launcherItem
                boundsBehavior: Flickable.StopAtBounds

                delegate: StyledRect {
                    id: row

                    required property int index
                    required property var modelData

                    readonly property bool current: index === window.selected

                    width: list.width
                    height: Appearance.sizes.launcherItem
                    radius: Appearance.rounding.normal
                    color: current ? Colours.alpha(Colours.m3primary, 0.16) : "transparent"

                    AppIcon {
                        id: appIcon

                        anchors.left: parent.left
                        anchors.leftMargin: Appearance.padding.large
                        anchors.verticalCenter: parent.verticalCenter
                        size: 26
                        icon: row.modelData.icon ?? ""
                        name: row.modelData.name ?? ""
                    }

                    Column {
                        anchors.left: appIcon.right
                        anchors.leftMargin: Appearance.spacing.large
                        anchors.right: parent.right
                        anchors.rightMargin: Appearance.padding.large
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 0

                        StyledText {
                            width: parent.width
                            text: row.modelData.name
                            elide: Text.ElideRight
                            color: row.current ? Colours.m3primary : Colours.m3onSurface
                            font.pixelSize: Appearance.font.size.normal
                        }

                        StyledText {
                            width: parent.width
                            visible: text.length > 0
                            text: row.modelData.genericName || row.modelData.comment || ""
                            elide: Text.ElideRight
                            color: Colours.m3outline
                            font.pixelSize: Appearance.font.size.small
                        }
                    }

                    StateLayer {
                        radius: parent.radius

                        onClicked: window.launch(row.index)
                        onPositionChanged: window.selected = row.index
                    }
                }
            }

            // Empty state.
            StyledText {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: searchRow.height / 2
                visible: list.count === 0 && input.text.length > 0
                text: "No matches"
                color: Colours.m3outline
            }
        }
    }
}
