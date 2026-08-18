import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.theme

ClippingRectangle {
    id: blueRec
    color: Colors.color3
    property int fontSize
    required property var device
    function getStateText(state) {
        switch (state) {
        case BluetoothDeviceState.Connected:
            return "Connected";
        case BluetoothDeviceState.Connecting:
            return "Connecting...";
        case BluetoothDeviceState.Disconnected:
            return "Disconnected";
        case BluetoothDeviceState.Disconnecting:
            return "Disconnecting...";
        default:
            return "Disconnected";
        }
    }
    Rectangle {
        id: iconRec
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }
        color: "transparent"
        implicitWidth: blueRec.device?.icon ? blueRec.fontSize * 2 : 0
        IconImage {
            id: icon
            anchors.centerIn: parent
            visible: blueRec.device?.icon
            source: Quickshell.iconPath(blueRec.device?.icon)
            implicitSize: blueRec.fontSize * 2
        }
    }
    ColumnLayout {
        id: details
        anchors {
            left: iconRec.right
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        spacing: 0
        Text {
            id: name
            text: String(blueRec.device?.name).trim()
            color: Colors.foreground
            elide: Text.ElideRight
            font.pixelSize: blueRec.fontSize
            Layout.maximumWidth: blueRec.width * 0.6
        }
        Text {
            id: status
            text: blueRec.getStateText(blueRec.device?.state)
            color: Colors.foreground
            font.pixelSize: blueRec.fontSize
        }
    }
    Rectangle {
        id: pairButton
        color: pairArea.containsMouse ? "#11000000" : "transparent"
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        z: 1
        visible: !blueRec.device?.paired || blueRec.device?.pairing
        anchors.fill: parent
        MouseArea {
            id: pairArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (!blueRec.device?.paired) {
                    blueRec.device?.pair();
                } else if (blueRec.device?.pairing) {
                    blueRec.device?.cancelPair();
                }
            }
        }
    }
    Rectangle {
        id: connectButton
        color: connectArea.containsMouse ? "#11000000" : "transparent"
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        anchors.fill: parent
        MouseArea {
            id: connectArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (blueRec.device?.connected) {
                    blueRec.device?.disconnect();
                } else {
                    blueRec.device?.connect();
                }
            }
        }
    }
    Rectangle {
        id: forRec
        visible: blueRec.device?.paired
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        implicitHeight: blueRec.fontSize * 2.5
        implicitWidth: height
        radius: height / 3
        color: forArea.containsMouse ? "#11000000" : "transparent"
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        MouseArea {
            id: forArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: blueRec.device?.forget()
        }
        Text {
            id: forgor
            color: forArea.containsMouse ? Colors.color15 : Colors.foreground
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            text: ""
            anchors.centerIn: parent
            font.pixelSize: blueRec.fontSize * 1.5
        }
    }
}
