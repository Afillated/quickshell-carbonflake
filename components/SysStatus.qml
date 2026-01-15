pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pipewire
import qs.services

Rectangle {
    id: systemStatus
    implicitWidth: text.width + 24
    implicitHeight: 30
    color: "#E6000000"
    radius: 15

    property string outIcon: Audio.defaultOutput?.audio.muted ? "󰝟" : "󰕾"

    property string inIcon: Audio.defaultInput?.audio.muted ? "󰍭" : "󰍬"

    border {
        color: "#960000"
        width: 1.5
    }
    Text {
        id: text
        anchors.centerIn: parent
        text: `${Network.status}  ${Bluetooth.status}  ${systemStatus.outIcon}  ${systemStatus.inIcon}`
        color: "#960000"
        font.pixelSize: 18
    }
}
