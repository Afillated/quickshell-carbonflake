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
    RowLayout {
        id: row
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 5
        IconImage {
            id: icon
            source: Quickshell.iconPath(blueRec.device?.icon)
            implicitSize: 20
        }
        ColumnLayout {
            id: details
            Layout.leftMargin: 10
            Text {
                id: name
                text: blueRec.device?.name
                color: "#967373"
            }
            Text {
                id: status
                text: blueRec.getStateText(blueRec.device?.state)
                color: "#967373"
            }
        }
    }
}
