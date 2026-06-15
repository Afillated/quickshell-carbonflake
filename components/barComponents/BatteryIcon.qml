pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import qs.services
import qs.theme

ClippingRectangle {
    id: batRec
    color: "transparent"
    radius: height / 2
    property real fontSize

    ProgressBar {
        id: batProgress
        anchors.fill: parent
        value: Battery.percentage
        from: 0
        to: 1

        background: Rectangle {
            id: bg
            color: "#313131"
            radius: batRec.radius
            clip: true
        }

        contentItem: Item {
            Rectangle {
                id: maskBuffer
                width: bg.width
                height: bg.height
                radius: batRec.radius
                color: "black"
                visible: false
            }

            Item {
                anchors.fill: parent
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: maskBuffer
                }

                Rectangle {
                    id: charged
                    width: batProgress.visualPosition * parent.width
                    height: parent.height
                    color: Colors.color10
                }
            }
        }
    }

    Row {
        id: textContainer
        anchors.centerIn: parent
        spacing: 2

        Text {
            id: chargeIndicator
            text: "󱐋"
            color: Colors.color15
            visible: Battery.isCharging
            font {
                pixelSize: batRec.fontSize * 0.8
                weight: 500
            }
        }
        Text {
            id: percent
            text: Math.floor(Battery.percentage * 100)
            color: Colors.color15
            font {
                pixelSize: batRec.fontSize * 0.8
                weight: 500
            }
        }
    }
}
