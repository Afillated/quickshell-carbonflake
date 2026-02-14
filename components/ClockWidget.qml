import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts
import qs.services

Rectangle {
    id: clockRec
    implicitHeight: 30
    implicitWidth: textTime.contentWidth + 10
    color: "#E6000000"
    radius: 15

    border {
        color: "#CC960000"
        width: 1.5
    }

    Text {
        id: textTime
        anchors.centerIn: clockRec
        text: Time.time
        color: "#C10000"
        font {
            family: "Firacode Mono Nerd Font"
            pixelSize: 20
        }
    }
}
