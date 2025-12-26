// Bar.qml

import Quickshell
import QtQuick 2.0
// import qs
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
                    rect.y: -10
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
            }
        }
    }
}
