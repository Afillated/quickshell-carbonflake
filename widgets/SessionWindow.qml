import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io

import qs.services

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: sessionPanel
            required property var modelData
            screen: modelData
            property bool isOpen: false
            visible: false
            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            IpcHandler {
                target: "sessionPanel"
                function open(): void {
                    sessionPanel.visible = true;
                }
                function close(): void {
                    sessionPanel.visible = false;
                }
            }
            focusable: true
            Shortcut {
                sequence: "Escape"
                onActivated: {
                    sessionPanel.visible = false;
                }
            }
            ClippingRectangle {
                id: sessionRec
                implicitHeight: sessionPanel.modelData.height * 0.175
                implicitWidth: sessionPanel.modelData.width * 0.3
                anchors.centerIn: parent
                radius: 10
                border {
                    width: 2
                    color: "#CC960000"
                }
                color: "#AA000000"
                Rectangle {
                    id: userDetails
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        left: parent.left
                    }
                    implicitHeight: parent.height / 6
                    color: "#88000000"
                    Text {
                        id: username
                        text: Username.user
                        color: "#967373"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: 8
                        }
                        font {
                            family: "Firacode Mono Nerd Font"
                            pixelSize: 18
                            weight: 420
                        }
                    }
                    Text {
                        id: uptime
                        text: "Uptime: " + Username.uptime
                        color: "#967373"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                            rightMargin: 8
                        }
                        font {
                            family: "Firacode Mono Nerd Font"
                            pixelSize: 18
                            weight: 420
                        }
                    }
                }
                RowLayout {
                    id: sessionBar
                    spacing: 8
                    anchors {
                        top: parent.top
                        bottom: userDetails.top
                        right: parent.right
                        left: parent.left
                        bottomMargin: 2
                        margins: 10
                    }
                    Rectangle {
                        id: lockButton
                        radius: 10
                        color: focus || area.containsMouse ? "#CC111111" : "#55000000"
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                        MouseArea {
                            id: area
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: {
                                LockContext.locked = true;
                                sessionPanel.visible = false;
                            }
                        }
                        focus: true
                        border {
                            color: focus ? "#CC960000" : "#111111"
                            width: 2
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }

                        Text {
                            text: ""
                            color: area.containsMouse || lockButton.focus ? "#960000" : "#967373"
                            anchors.centerIn: parent
                            font.pixelSize: 32
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        KeyNavigation.right: shutButton
                        Keys.onReturnPressed: {
                            LockContext.locked = true;
                            sessionPanel.visible = false;
                        }
                    }
                    Rectangle {
                        id: shutButton
                        radius: 10
                        color: focus || area2.containsMouse ? "#CC111111" : "#55000000"
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                        MouseArea {
                            id: area2
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
                        }
                        border {
                            color: focus ? "#CC960000" : "#111111"
                            width: 2
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        Text {
                            text: "󰐥"
                            color: area2.containsMouse || shutButton.focus ? "#960000" : "#967373"
                            anchors.centerIn: parent
                            font.pixelSize: 34
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        Keys.onReturnPressed: Quickshell.execDetached(["systemctl", "poweroff"])

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        KeyNavigation.right: restartButton
                        KeyNavigation.left: lockButton
                    }
                    Rectangle {
                        id: restartButton
                        radius: 10
                        color: focus || area3.containsMouse ? "#CC111111" : "#55000000"
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                        MouseArea {
                            id: area3
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: Quickshell.execDetached(["systemctl", "reboot"])
                        }
                        border {
                            color: focus ? "#CC960000" : "#111111"
                            width: 2
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }

                        Text {
                            text: "󰜉"
                            color: area3.containsMouse || restartButton.focus ? "#960000" : "#967373"
                            anchors.centerIn: parent
                            font.pixelSize: 34
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        KeyNavigation.right: logButton
                        KeyNavigation.left: shutButton
                        Keys.onReturnPressed: Quickshell.execDetached(["systemctl", "reboot"])
                    }
                    Rectangle {
                        id: logButton
                        radius: 10
                        color: focus || area4.containsMouse ? "#CC111111" : "#55000000"
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                        MouseArea {
                            id: area4
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: Quickshell.execDetached(["uwsm", "stop"])
                        }
                        border {
                            color: focus ? "#CC960000" : "#111111"
                            width: 2
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        Text {
                            text: "󰍃"
                            color: area4.containsMouse || logButton.focus ? "#960000" : "#967373"
                            anchors.centerIn: parent
                            font.pixelSize: 32
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        KeyNavigation.left: restartButton
                        Keys.onReturnPressed: Quickshell.execDetached(["uwsm","stop"])
                    }
                }
            }
        }
    }
}
