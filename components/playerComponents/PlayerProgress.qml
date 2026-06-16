import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

import qs.services
import qs.theme

Slider {
    id: progress
    from: 0
    to: parseInt(MprisPlayers.activePlayer?.length || "0", 10)
    stepSize: 1
    value: parseInt(MprisPlayers.activePlayer?.position || "0", 10)
    snapMode: Slider.NoSnap
    onMoved: {
        MprisPlayers.activePlayer.position = value;
    }
    background: ClippingRectangle {
        x: progress.leftPadding
        y: progress.topPadding + progress.availableHeight / 2 - height / 2
        implicitHeight: parent.height
        width: progress.availableWidth
        height: implicitHeight
        radius: height / 3
        color: "#55967373"

        Rectangle {
            width: progress.visualPosition * parent.width
            height: parent.height
            color: Colors.color3
            radius: height / 3
        }
    }
    handle: Rectangle {
        x: progress.leftPadding + progress.visualPosition * (progress.availableWidth - width)
        y: progress.topPadding + progress.availableHeight / 2 - height / 2
        implicitHeight: parent.height * 2
        implicitWidth: height
        radius: height / 2
        color: Colors.color15
    }
}
