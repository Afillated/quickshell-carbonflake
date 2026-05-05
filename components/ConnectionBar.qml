import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services

Rectangle {
    id: connectRec
    signal openWifi
    signal openBlue

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 8
        Rectangle {
            id: wifi
            color: "#55000000"
            radius: 10
            border {
                color: "#111111"
                width: 2
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: bluetooth
            color: openArea.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
            radius: 10
            border {
                color: "#111111"
                width: 2
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
            MouseArea {
                id: openArea
                anchors.fill: parent
                z: 1
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: connectRec.openBlue()
            }
            ColumnLayout {
                id: blueRow
                anchors {
                    left: toggle.right
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
                spacing: 8
                Text {
                    id: blueLabel
                    text: "Bluetooth"
                    color: "#967373"
                    font {
                        family: "Comfortaa"
                        pixelSize: 18
                        weight: 500
                    }
                }
                Text {
                    id: blueState
                    text: {
                        if (Bluetooth.devices?.values.filter(device => device.connected).length === 1) {
                            return "Connected";
                        } else if (!Bluetooth.enabled) {
                            return "Off";
                        } else {
                            return "No devices connected";
                        }
                    }
                    Layout.maximumWidth: 140
                    wrapMode: Text.WordWrap
                    color: "#967373"
                    font {
                        family: "Comfortaa"
                        pixelSize: 12
                        weight: 400
                    }
                }
            }
            Rectangle {
                id: toggle
                z: 2
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    bottomMargin: 8
                    topMargin: 8
                    leftMargin: 8
                }
                radius: 8
                width: 60
                color: Bluetooth.enabled ? "#550000" : "#55967373"
                MouseArea {
                    id: area
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Bluetooth.toggleDefault()
                    cursorShape: Qt.PointingHandCursor
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }
                Text {
                    id: symbol
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 20
                    }
                    text: {
                        if (!Bluetooth.enabled)
                            return "󰂲";
                        if (Bluetooth.devices?.values.filter(device => device.connected).length > 0)
                            return "󰂱";
                        return "󰂯";
                    }
                    color: Bluetooth.enabled ? "black" : "#967373"
                    font {
                        pixelSize: 30
                        family: "Comfortaa"
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                        }
                    }
                }
            }
        }
    }
}
