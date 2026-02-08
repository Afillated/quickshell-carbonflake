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

    property string outIcon: Audio.defaultOutput?.audio.muted || Audio.defaultOutput?.audio.volume === 0 ? "󰝟" : "󰕾"

    property string inIcon: Audio.defaultInput?.audio.muted || Audio.defaultInput?.audio.volume === 0 ? "󰍭" : "󰍬"

    border {
        color: "#CC960000"
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
