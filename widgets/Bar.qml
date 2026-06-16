import Quickshell
import Quickshell.Widgets
import QtQuick

import qs.theme
import qs.components.barComponents

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: mainBar
            required property var modelData
            screen: modelData
            color: "transparent"
            implicitHeight: Math.floor(screen.height / 20)
            anchors {
                bottom: true
                right: true
                left: true
            }
            property bool isPinned: true
            exclusiveZone: isPinned ? barRec.height + height / 10 : height / 4
            Rectangle {
                id: hoverRec
                visible: !mainBar.isPinned
                color: "transparent"
                anchors {
                    bottom: parent.bottom
                    left: barRec.left
                    right: barRec.right
                }
                implicitHeight: mainBar.exclusiveZone
                MouseArea {
                    id: hoverArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
            mask: Region {
                Region {
                    item: hoverRec
                }
                Region {
                    item: barRec
                }
            }

            ClippingRectangle {
                id: barRec
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                implicitHeight: Math.floor(parent.height * 0.8)
                implicitWidth: Math.floor(parent.width * 0.98)
                radius: Math.floor(height / 3)
                color: Colors.transground
                border {
                    color: Colors.color3
                    width: 2
                }
                HoverHandler {
                    id: recHover
                }
                LeftRow {
                    id: leftRow
                    fontSize: Math.floor(parent.height * 0.48)
                    barRecHeight: parent.height
                    barRecWidth: parent.width
                    barHeight: mainBar.height
                    barWidth: mainBar.width
                    window: mainBar
                    anchors {
                        left: parent.left
                        leftMargin: mainBar.height / 5
                        verticalCenter: parent.verticalCenter
                    }
                }
                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height * 0.6
                    width: name.width + height / 2
                    radius: height / 3
                    MouseArea {
                        id: pinArea
                        anchors.fill: parent
                        onClicked: {
                            mainBar.isPinned = !mainBar.isPinned;
                        }
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                    }
                    color: pinArea.containsMouse ? "#33AAAAAA" : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    Text {
                        id: name
                        anchors.centerIn: parent
                        text: mainBar.isPinned ? "Unpin" : "Pin"
                        font.pixelSize: Math.floor(barRec.height * 0.48)
                        color: pinArea.containsMouse ? Colors.color12 : Colors.color15
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                RightRow {
                    id: rightRow
                    fontSize: Math.floor(parent.height * 0.48)
                    barRecHeight: parent.height
                    barRecWidth: parent.width
                    barHeight: mainBar.height
                    barWidth: mainBar.width
                    window: mainBar
                    anchors {
                        right: parent.right
                        rightMargin: mainBar.height / 5
                        verticalCenter: parent.verticalCenter
                    }
                }
                state: {
                    if (mainBar.isPinned)
                        return "Pinned";
                    if (hoverArea.containsMouse || recHover.hovered || leftRow.stayOpen || rightRow.stayOpen)
                        return "Peek";
                    return "Hidden";
                }
                states: [
                    State {
                        name: "Pinned"
                        AnchorChanges {
                            target: barRec
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.top: undefined
                        }
                    },
                    State {
                        name: "Peek"
                        AnchorChanges {
                            target: barRec
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.top: undefined
                        }
                    },
                    State {
                        name: "Hidden"
                        AnchorChanges {
                            target: barRec
                            anchors.top: parent.bottom
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
                transitions: [
                    Transition {
                        from: "*"
                        to: "*"
                        AnchorAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                        NumberAnimation {
                            properties: "opacity"
                            duration: 250
                        }
                    }
                ]
            }
        }
    }
}
