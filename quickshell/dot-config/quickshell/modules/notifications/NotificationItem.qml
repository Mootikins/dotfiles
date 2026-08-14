pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import qs.config
import qs.components

// A single notification card.
StyledRect {
    id: root

    required property Notification notification

    // Urgency now shows only in the border colour; the left accent stripe was
    // removed. `low` is unused as a result -- critical is what drives styling
    // and the no-auto-dismiss behaviour.
    readonly property bool critical: notification.urgency === NotificationUrgency.Critical

    // Senders may pass -1 ("let the server decide") or 0 ("never expire").
    readonly property int timeout: {
        if (critical)
            return 0;
        const t = notification.expireTimeout;
        if (t > 0)
            return t;
        if (t === 0)
            return 0;
        return Settings.notificationTimeout;
    }

    implicitWidth: Appearance.sizes.notifWidth
    implicitHeight: layout.implicitHeight + Appearance.padding.larger * 2

    radius: Appearance.rounding.large
    color: Colours.m3surfaceContainer
    border.width: 1
    border.color: critical ? Colours.alpha(Colours.m3error, 0.9) : Colours.alpha(Colours.m3outlineVariant, 0.8)

    // Auto-dismiss. Critical notifications stay until acted on.
    Timer {
        running: root.timeout > 0 && !hover.containsMouse
        interval: root.timeout
        onTriggered: root.notification.dismiss()
    }

    MouseArea {
        id: hover

        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        onClicked: event => {
            if (event.button === Qt.MiddleButton) {
                root.notification.dismiss();
                return;
            }
            // Left click invokes the default action if there is one.
            const acts = root.notification.actions ?? [];
            for (const a of acts)
                if (a.identifier === "default") {
                    a.invoke();
                    return;
                }
            root.notification.dismiss();
        }
    }

    RowLayout {
        id: layout

        anchors.fill: parent
        anchors.margins: Appearance.padding.larger
        spacing: Appearance.spacing.large

        // Icon / image. A notification may carry a raw image (hint or path) or
        // just an icon name; the former is used as-is, the latter goes through
        // AppIcon so a missing theme icon becomes a lettered tile.
        Loader {
            Layout.alignment: Qt.AlignTop

            readonly property string rawImage: root.notification.image ?? ""

            sourceComponent: rawImage ? imageComp : iconComp

            Component {
                id: imageComp

                IconImage {
                    implicitSize: Appearance.sizes.notifIcon
                    asynchronous: true
                    source: root.notification.image
                }
            }

            Component {
                id: iconComp

                AppIcon {
                    size: Appearance.sizes.notifIcon
                    icon: root.notification.appIcon ?? ""
                    name: root.notification.appName ?? ""
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: Appearance.spacing.small

            RowLayout {
                Layout.fillWidth: true
                spacing: Appearance.spacing.small

                StyledText {
                    Layout.fillWidth: true
                    text: root.notification.summary
                    font.pixelSize: Appearance.font.size.normal
                    font.bold: true
                    elide: Text.ElideRight
                    color: Colours.m3onSurface
                }

                StyledText {
                    text: root.notification.appName
                    font.pixelSize: Appearance.font.size.small
                    color: Colours.m3outline
                    elide: Text.ElideRight
                    Layout.maximumWidth: 110
                }
            }

            StyledText {
                Layout.fillWidth: true
                visible: text.length > 0
                text: root.notification.body
                // Senders commonly send Pango-ish markup; StyledText is
                // PlainText by default, so opt this one field into rich text.
                textFormat: Text.StyledText
                font.pixelSize: Appearance.font.size.small
                color: Colours.m3onSurfaceVariant
                wrapMode: Text.Wrap
                maximumLineCount: 4
                elide: Text.ElideRight
                onLinkActivated: link => Qt.openUrlExternally(link)
            }

            // Actions (the implicit "default" action is not a button).
            Flow {
                Layout.fillWidth: true
                Layout.topMargin: Appearance.padding.small
                spacing: Appearance.spacing.small
                visible: repeater.count > 0

                Repeater {
                    id: repeater

                    model: {
                        const out = [];
                        for (const a of (root.notification.actions ?? []))
                            if (a.identifier !== "default")
                                out.push(a);
                        return out;
                    }

                    StyledRect {
                        id: btn

                        required property var modelData

                        implicitWidth: actionLabel.implicitWidth + Appearance.padding.large * 2
                        implicitHeight: actionLabel.implicitHeight + Appearance.padding.normal * 2
                        radius: Appearance.rounding.full
                        color: Colours.alpha(Colours.m3primary, 0.14)

                        StyledText {
                            id: actionLabel

                            anchors.centerIn: parent
                            text: btn.modelData.text
                            font.pixelSize: Appearance.font.size.small
                            color: Colours.m3primary
                        }

                        StateLayer {
                            radius: parent.radius
                            layerColor: Colours.m3primary

                            onClicked: btn.modelData.invoke()
                        }
                    }
                }
            }
        }
    }
}
