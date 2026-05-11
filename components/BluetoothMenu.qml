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
        color: "#967373"
        padding: 10
        font {
            family: "Comfortaa"
            weight: 500
            pixelSize: 40
        }
        background: ClippingRectangle {
            radius: 20
            color: "transparent"
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 30
        }
    }
    Rectangle {
        id: actionBar
        anchors {
            top: titleL.bottom
            left: parent.left
            right: parent.right
            margins: 10
        }
        implicitHeight: 50
        color: "transparent"
        radius: 20
        border {
            width: 2
            color: "#CC960000"
        }

        Rectangle {
            id: scanButton
            anchors {
                right: parent.right
                rightMargin: 12
                verticalCenter: parent.verticalCenter
            }
            width: 100
            height: 30
            radius: 8
            visible: opacity > 0
            opacity: Bluetooth.enabled ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InCirc
                }
            }
            color: scan.containsMouse ? "#CC111111" : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
            border {
                color: scan.containsMouse ? "#CC960000" : "#111111"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Text {
                id: scanText
                anchors.centerIn: parent
                color: scan.containsMouse ? "#960000" : "#967373"
                font {
                    family: "Comfortaa"
                    pixelSize: 16
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
                text: {
                    if (Bluetooth.scanning) {
                        return "Stop";
                    } else {
                        return "Scan";
                    }
                }
            }
            MouseArea {
                id: scan
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    Bluetooth.toggleScaning();
                }
            }
        }
        Switch {
            id: toggle
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
            checked: Bluetooth.enabled
            onClicked: Bluetooth.toggleDefault()
            indicator: Rectangle {
                implicitHeight: 24
                implicitWidth: 45
                x: toggle.leftPadding
                y: parent.height / 2 - height / 2
                radius: 13
                color: toggle.checked ? "#960000" : "#55967373"
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Rectangle {
                    x: toggle.checked ? parent.width - width : 0
                    Behavior on x {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                    width: 24
                    height: 24
                    radius: height / 2
                    color: "#967373"
                }
            }
        }
        Text {
            id: state
            text: {
                if (Bluetooth.enabled) {
                    return "On";
                } else {
                    return "Off";
                }
            }
            font {
                pixelSize: 16
                family: "Comfortaa"
                weight: 600
            }
            anchors {
                left: toggle.right
                top: parent.top
                topMargin: 18
                leftMargin: -2
            }
            color: "#967373"
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
        id: body
        anchors {
            bottom: closeButton.top
            right: parent.right
            left: parent.left
            top: actionBar.bottom
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
                    duration: 250
                    easing.type: Easing.InCirc
                }
            }

            delegate: BlueCard {
                required property var modelData
                width: deviceList.width
                implicitHeight: 60
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
                visible: opacity > 0
                opacity: deviceList.count === 0 && Bluetooth.enabled ? 1 : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.InCirc
                    }
                }
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
            visible: opacity > 0
            opacity: !Bluetooth.enabled ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InCirc
                }
            }
            color: "#967373"
            font {
                pixelSize: 18
                family: "Comfortaa"
                weight: 500
            }
        }
    }
}
