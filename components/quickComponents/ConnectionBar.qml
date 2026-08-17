import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.services

ClippingRectangle {
    id: connectRec
    color: Colors.transground2
    border {
        width: 2
        color: Colors.color3
    }

    property real fontSize
    property int butRadius
    signal openWif
    signal openBlue

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        ClippingRectangle {
            id: wifRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: connectRec.butRadius
            MouseArea {
                id: wifArea
                anchors.fill: parent
                z: -1
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: connectRec.openWif()
            }
            color: wifArea.containsMouse ? "#11CCCCCC" : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            border {
                color: wifArea.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            // something like this(never done wifi with qs nm lib before so yay)
            // RowLayout {
            //     anchors.fill: parent
            //     anchors.margins: 10
            //     ClippingRectangle {
            //         id: toggle
            //         radius: connectRec.butRadius
            //         Layout.fillHeight: true
            //         Layout.fillWidth: true
            //     }
            //     ColumnLayout {
            //         Text {
            //             text: "placeholder"
            //             color: "white"
            //         }
            //         Text {
            //             text: "placeholder"
            //             color: "white"
            //         }
            //     }
            // }
        }
        ClippingRectangle {
            id: blueRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: connectRec.butRadius
            MouseArea {
                id: blueArea
                anchors.fill: parent
                z: -1
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: connectRec.openBlue()
            }
            color: blueArea.containsMouse ? "#11CCCCCC" : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            border {
                color: blueArea.containsMouse || blueToggle.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10
                ClippingRectangle {
                    id: toggle
                    radius: connectRec.butRadius
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Bluetooth.enabled ? Colors.color13 : "#55967373"
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    MouseArea {
                        id: blueToggle
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Bluetooth.toggleDefault()
                        cursorShape: Qt.PointingHandCursor
                    }
                    Text {
                        id: symbol
                        anchors.centerIn: parent
                        text: {
                            if (!Bluetooth.enabled)
                                return "󰂲";
                            if (Bluetooth.isConnected)
                                return "󰂱";
                            return "󰂯";
                        }
                        color: Bluetooth.enabled ? Colors.background : Colors.color15
                        font {
                            pixelSize: connectRec.fontSize * 1.8
                        }
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                ColumnLayout {
                    Text {
                        id: blueLabel
                        text: "Bluetooth"
                        color: blueArea.containsMouse ? Colors.color14 : Colors.color15
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                        font {
                            pixelSize: connectRec.fontSize * 1.2
                            weight: 500
                        }
                    }
                    Text {
                        id: blueState
                        text: {
                            if (Bluetooth.isConnected) {
                                return "Connected";
                            } else if (!Bluetooth.enabled) {
                                return "Off";
                            } else {
                                return "On";
                            }
                        }
                        color: Bluetooth.isConnected || Bluetooth.enabled ? Colors.color15 : "#976363"
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                        font {
                            pixelSize: connectRec.fontSize
                            weight: 400
                        }
                    }
                }
            }
        }
    }
}
