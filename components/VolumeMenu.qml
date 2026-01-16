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
    implicitHeight: 120

    Slider {
        id: micSlider
        value: Audio.defaultInVolume
        from: 0
        to: 1.53
        stepSize: 0.01
        live: true
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            left: parent.left
            leftMargin: 20
            right: parent.right
            rightMargin: 70
        }
        background: Rectangle {
            implicitHeight: 30
            radius: 30
            color: "#55967373"
            clip: true

            Rectangle {
                width: micSlider.visualPosition * parent.width
                height: parent.height
                radius: 20
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
            radius: 20
            color: "transparent"
            PointHandler {
                cursorShape:micSlider.pressed ?  Qt.ClosedHandCursor : Qt.SizeHorCursor
            }
            
        }
        onValueChanged: {
            Audio.defaultInput.audio.volume = value;
        }
    }

    Slider {
        id: volumeSlider
        value: Audio.defaultOutVolume
        from: 0
        to: 1
        stepSize: 0.01
        live: true
        anchors {
            top: parent.top
            topMargin: 20
            left: parent.left
            leftMargin: 20
            right: parent.right
            rightMargin: 70
        }
        background: Rectangle {
            implicitHeight: 30
            radius: 30
            color: "#55967373"
            clip: true

            Rectangle {
                width: volumeSlider.visualPosition * parent.width
                height: parent.height
                radius: 20
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
            x: volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
            height: 20
            width: 20
            radius: 10
            color: "transparent"
            PointHandler {
                cursorShape:volumeSlider.pressed ?  Qt.ClosedHandCursor : Qt.SizeHorCursor
            }
            
        }
        onValueChanged: {
            Audio.defaultOutput.audio.volume = value;
        }
    }

    Rectangle {
        id: volumeMuteButton
        implicitHeight: 30
        implicitWidth: 30
        radius: 30
        anchors {
            left: volumeSlider.right
            leftMargin: 20
            right: parent.right
            rightMargin: 20
            top: parent.top
            topMargin:20
        }

        color: Audio.defaultOutput.audio.volume === 0 || Audio.defaultOutput.audio.muted ? "#55967373" : "#AA0000"

        Text {
            anchors.centerIn: parent
            text: Audio.defaultOutput.audio.volume === 0 || Audio.defaultOutput.audio.muted ? "󰝟" : "󰕾"
            font.pixelSize: 24
            color: Audio.defaultOutput.audio.volume === 0 || Audio.defaultOutput.audio.muted ? "#967373" : "#000000"
        }

        MouseArea {
            id: volumeMuteArea
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: Audio.toggleOutputMute();
        }
    }

    Rectangle {
        id: micMuteButton
        implicitHeight: 30
        implicitWidth: 30
        radius: 30
        anchors {
            left: micSlider.right
            leftMargin: 20
            right: parent.right
            rightMargin: 20
            bottom: parent.bottom
            bottomMargin:20
        }

        color: Audio.defaultInput.audio.volume === 0 || Audio.defaultInput.audio.muted ? "#55967373" : "#AA0000"

        Text {
            anchors.centerIn: parent
            text: Audio.defaultInput.audio.volume === 0 || Audio.defaultInput.audio.muted ? "󰍭" : "󰍬"
            font.pixelSize: 24
            color: Audio.defaultInput.audio.volume === 0 || Audio.defaultInput.audio.muted ? "#967373" : "#000000"
        }

        MouseArea {
            id: micMuteArea
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: Audio.toggleInputMute();
        }
    }
}
