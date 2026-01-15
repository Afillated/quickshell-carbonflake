import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import qs.services

Rectangle {
    id: volumeRec
    color: "transparent"
    border {
        color: "#668F8F8F"
        width: 1.5
    }
    radius: 20
    implicitHeight: 100

    Slider {
        id: micSlider
        value: 30
        from: 0
        to: 1
        stepSize: 0.01
        live: true
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 100
        }
        background: Rectangle {
            implicitHeight: 20
            implicitWidth: 100
            radius: 10
            color: "#55967373"

            Rectangle {
                width: micSlider.visualPosition * parent.width
                height: parent.height
                radius: 10
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop {
                        position: 0.0
                        color: "#550000"
                    }
                    GradientStop {
                        position: 1.0
                        color: "#AA0000"
                    }
                }
            }
        }

        handle: Rectangle {
            x: micSlider.visualPosition * (micSlider.availableWidth - width)
            height: 20
            width: 20
            radius: 10
            color: "transparent"
        }
        onValueChanged: {
            Audio.defaultInput.audio.volume = value;
        }
    }
}
