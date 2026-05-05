pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets

import qs.services

ClippingRectangle {
    id: menuRec
    signal close
    radius: 10
    color: "#010101"
    Label {
        id: titleL
        text: "Bluetooth"
        color: labelA.containsMouse ? "#960000" : "#967373"
        padding: 10
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
        font {
            family: "Comfortaa"
            weight: 500
            pixelSize: 40
        }
        background: ClippingRectangle {
            radius: 20
            color: labelA.containsMouse ? "#CC111111" : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 30
        }
        MouseArea {
            id: labelA
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }

    Rectangle {
        id: closeButton
        color: close.containsMouse ? "#CC111111" : "transparent"
        radius: 20
        implicitHeight: 40
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 20
        }
        border {
            color: "#222222"
            width: 2
        }
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        MouseArea {
            id: close
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            anchors.fill: parent
            onClicked: menuRec.close()
        }
        Text {
            text: "Close"
            color: close.containsMouse ? "#960000" : "#967373"
            anchors.centerIn: parent
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            font {
                family: "Comfortaa"
                weight: 500
                pixelSize: 20
            }
        }
    }
    ClippingRectangle {
        anchors {
            bottom: closeButton.top
            right: parent.right
            left: parent.left
            top: titleL.bottom
            margins: 10
        }
        color: "transparent"
        radius: 20
        border {
            width: 2
            color: "#CC960000"
        }
        ListView {
            id: deviceList
            anchors {
                fill: parent
                margins: 10
            }

            clip: true
            model: Bluetooth.devices
            spacing: 10
            opacity: Bluetooth.enabled ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            delegate: BlueCard {
                required property var modelData
                width: deviceList.width
                implicitHeight: 50
                device: modelData
            }
            section.property: "paired"
            section.delegate: Text {
                id: header
                required property string section
                width: deviceList.width
                height: 30
                text: (header.section === "true" || header.section === "1") ? "Paired" : "Available"
                color: "#967373"
                font {
                    pixelSize: 18
                    family: "Comfortaa"
                    weight: 500
                }
            }
            add: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        property: "scale"
                        from: 0.8
                        to: 1
                        duration: 250
                        easing.type: Easing.OutBack
                    }
                }
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        to: 0
                        duration: 150
                        easing.type: Easing.InCubic
                    }
                    NumberAnimation {
                        property: "scale"
                        to: 0.8
                        duration: 200
                        easing.type: Easing.InCubic
                    }
                }
            }

            displaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            Text {
                anchors.centerIn: parent
                text: "No devices found"
                visible: deviceList.count === 0 && Bluetooth.enabled
                color: "#967373"
                font {
                    pixelSize: 18
                    family: "Comfortaa"
                    weight: 500
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: "Turn on bluetooth to see devices"
            visible: !Bluetooth.enabled
            color: "#967373"
            font {
                pixelSize: 18
                family: "Comfortaa"
                weight: 500
            }
        }
    }
}
