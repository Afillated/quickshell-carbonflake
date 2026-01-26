// Bar.qml

import Quickshell
import QtQuick 2.0
import qs.components
import qs.panels

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: mainBar
            required property var modelData
            screen: modelData
            color: "transparent"
            anchors {
                bottom: true
                left: true
                right: true
            }

            implicitHeight: 40

            HyprWS {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 10
                }
            }

            NotificationCenter {
                id: notificationPanel
                anchor {
                    window: mainBar
                    rect.x: 10
                    rect.y: -11
                }
            }

            ClockWidget {
                id: clock
                anchors {
                    left: parent.left
                    leftMargin: 10
                    bottom: parent.bottom
                    bottomMargin: 10
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        notificationPanel.visible = !notificationPanel.visible;
                    }
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }

            NowPlaying {
                id: nowBar
                anchors {
                    left: clock.right
                    leftMargin: 10
                    bottom: parent.bottom
                    bottomMargin: 10
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playerPopup.visible = !playerPopup.visible;
                    }
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }

            PlayerPanel {
                id: playerPopup
                anchor {
                    window: mainBar
                    rect.x: 10
                    rect.y: -11
                }
            }

            ActiveWindow {
                anchors {
                    right: sysStats.left
                    rightMargin: 10
                    bottom: parent.bottom
                    bottomMargin: 10
                }
            }

            SysStatus {
                id: sysStats
                anchors {
                    right: parent.right
                    rightMargin: 10
                    bottom: parent.bottom
                    bottomMargin: 10
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        quickPanel1.visible = !quickPanel1.visible;
                    }
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }
            QuickPanel {
                id: quickPanel1
                anchor {
                    window: mainBar
                    rect.x: 1910
                    rect.y: -11
                }
            }
        }
    }
}
