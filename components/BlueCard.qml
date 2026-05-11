import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ClippingRectangle {
    id: blueRec
    color: "#200000"
    radius: 10

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
        implicitWidth: 40
        IconImage {
            id: icon
            anchors.centerIn: parent
            source: blueRec.device?.icon ? Quickshell.iconPath(blueRec.device?.icon) : Qt.resolvedUrl("../assets/bluetooth.svg")
            implicitSize: 30
        }
    }
    ColumnLayout {
        id: details
        anchors {
            left: iconRec.right
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        Text {
            id: name
            text: String(blueRec.device?.name).trim()
            color: "#967373"
            elide: Text.ElideRight
            Layout.maximumWidth: 200
        }
        Text {
            id: status
            text: blueRec.getStateText(blueRec.device?.state)
            // text: blueRec.device.icon
            color: "#967373"
        }
    }
    Rectangle {
        id: pairButton
        color: pairArea.containsMouse ? "#11CCCCCC" : "transparent"
        // radius: 10
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
    RowLayout {
        id: pairRow
        visible: blueRec.device?.paired
        spacing: 5
        height: 40
        width: 100
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
        Rectangle {
            id: connectButton
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: connectArea.containsMouse ? "#11CCCCCC" : "transparent"
            radius: 10
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
            Text {
                id: dicon
                text: {
                    if (blueRec.device?.connected) {
                        return "";
                    } else {
                        return "󰂱";
                    }
                }
                color: connectArea.containsMouse ? "#960000" : "#967373"
                anchors.centerIn: parent
                font.pixelSize: 24
            }
        }
        Rectangle {
            id: forButton
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: forArea.containsMouse ? "#11CCCCCC" : "transparent"
            radius: 10
            MouseArea {
                id: forArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: blueRec.device?.forget()
            }
            Text {
                id: forgor
                color: forArea.containsMouse ? "#960000" : "#967373"
                text: "󰂲"
                anchors.centerIn: parent
                font.pixelSize: 24
            }
        }
    }
}
