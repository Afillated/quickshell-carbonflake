import Quickshell
import qs.services
import QtQuick.Controls
import QtQuick
import QtQuick.Shapes

Slider {
    id: progressBar
    from: 0
    to: MprisPlayers.activePlayer?.length
    stepSize: 1
    value: MprisPlayers.activePlayer?.position
    onMoved: {
        MprisPlayers.activePlayer.position = value;
    }
    background: Rectangle {
        x: progressBar.leftPadding
        y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: progressBar.availableWidth
        height: implicitHeight
        radius: 5
        color: "#55967373"

        Rectangle {
            width: progressBar.visualPosition * parent.width
            height: parent.height
            color: "#960000"
            radius: 2
        }
    }

    handle: Rectangle {
        x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
        y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
        implicitHeight: 10
        implicitWidth: 10
        radius: 10
        color: "#9C9C9C"
    }
}
