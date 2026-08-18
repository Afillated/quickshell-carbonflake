pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.theme
import qs.services
import qs.components.quickComponents

ClippingRectangle {
    id: menuRec
    color: Colors.background
    signal close
    property int fontSize
    property string butRadius
    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 10
        Label {
            id: title
            text: "Bluetooth"
            color: Colors.color15
            font.pixelSize: menuRec.fontSize * 3
            font.family: "Comfortaa"
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: menuRec.fontSize
            Layout.bottomMargin: menuRec.fontSize
        }
        ClippingRectangle {
            id: actionRec
            color: "transparent"
            radius: menuRec.butRadius
            Layout.fillWidth: true
            border {
                color: Colors.color3
                width: 2
            }
            implicitHeight: menuRec.fontSize * 3
            Switch {
                id: toggle
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: menuRec.fontSize * 0.6
                }
                checked: Bluetooth.enabled
                onClicked: Bluetooth.toggleDefault()
                indicator: Rectangle {
                    implicitHeight: menuRec.fontSize * 1.6
                    implicitWidth: height * 2
                    x: toggle.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: height / 3
                    color: toggle.checked ? Colors.color13 : "#55967373"
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
                        width: height
                        height: menuRec.fontSize * 1.6
                        radius: height / 3
                        color: Colors.color15
                    }
                }
            }
            Rectangle {
                id: scanButton
                anchors {
                    right: parent.right
                    rightMargin: menuRec.fontSize
                    verticalCenter: parent.verticalCenter
                }
                implicitHeight: menuRec.fontSize * 1.8
                implicitWidth: height * 2.5
                radius: height / 3
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
                        duration: 200
                    }
                }
                border {
                    color: scan.containsMouse ? Colors.color3 : "#212121"
                    width: 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                Text {
                    id: scanText
                    anchors.centerIn: parent
                    color: scan.containsMouse ? Colors.color14 : Colors.color15
                    font {
                        pixelSize: menuRec.fontSize * 1
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
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
        }
        ClippingRectangle {
            id: listRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: menuRec.butRadius
            color: "transparent"
            border {
                color: Colors.color3
                width: 2
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
                    fontSize: menuRec.fontSize
                    radius: 10
                    implicitHeight: menuRec.fontSize * 3
                    device: modelData
                }
                section.property: "paired"
                section.delegate: Text {
                    id: header
                    required property string section
                    width: deviceList.width
                    height: menuRec.fontSize * 1.5
                    text: (header.section === "true" || header.section === "1") ? "Paired" : "Available"
                    color: Colors.color15
                    font {
                        pixelSize: menuRec.fontSize
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
                        pixelSize: menuRec.fontSize
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
                color: Colors.foreground
                font {
                    pixelSize: menuRec.fontSize
                    family: "Comfortaa"
                    weight: 500
                }
            }
        }
        Rectangle {
            id: closeButton
            color: close.containsMouse ? "#CC111111" : "transparent"
            radius: height / 3
            implicitHeight: text.height * 1.5
            implicitWidth: parent.width / 1.5
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: layout.anchors.margins / 2
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
                id: text
                text: "Close"
                color: close.containsMouse ? Colors.color10 : Colors.foreground
                anchors.centerIn: parent
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                font {
                    weight: 500
                    pixelSize: menuRec.fontSize * 1.5
                }
            }
        }
    }
}
