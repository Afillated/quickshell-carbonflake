import QtQuick
import Quickshell

import qs.services

Rectangle {
    id: systemStatus
    implicitWidth:text.width + 24
    implicitHeight: 30
    color: "#E6000000"
    radius: 15
    border {
        color: "#960000"
        width: 1.5
    }
    Text {
        id: text
        anchors.centerIn: parent
        text: `${Network.status}  ${Bluetooth.status}`
        color: "#960000"
        font.pixelSize: 18
    }
}
