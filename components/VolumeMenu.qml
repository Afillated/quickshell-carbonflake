import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs.services

Rectangle {
    id: volumeRec
    color: "transparent"
    signal open

    signal open2
    border {
        color: "#CC960000"
        width: 1.5
    }
    Rectangle {
        id: openButton
        color: area.containsMouse ? "#66967373" : "#55967373"
        radius: 15
        implicitHeight: 30
        implicitWidth: 30
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
        anchors {
            verticalCenter: volumeSlider.verticalCenter
            left: volumeSlider.right
            leftMargin: 20
        }
        z: 1
        MouseArea {
            id: area
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: volumeRec.open()
        }
        Text {
            anchors.centerIn: parent
            text: "󰇙"
            font.pixelSize: 24
            color: area.containsMouse ? "#AA0000" : "#967373"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
    }
    Rectangle {
        id: openButton2
        color: area2.containsMouse ? "#66967373" : "#55967373"
        radius: 15
        implicitHeight: 30
        implicitWidth: 30
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
        anchors {
            verticalCenter: micSlider.verticalCenter
            left: micSlider.right
            leftMargin: 20
        }
        z: 1
        MouseArea {
            id: area2
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: volumeRec.open2()
        }
        Text {
            anchors.centerIn: parent
            text: "󰇙"
            font.pixelSize: 24
            color: area2.containsMouse ? "#AA0000" : "#967373"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
    }

    Slider {
        id: micSlider
        value: Audio.defaultInput?.audio.volume
        from: 0
        to: 1
        stepSize: 0.01
        live: true
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            left: parent.left
            leftMargin: 70
            right: parent.right
            rightMargin: 70
        }
        background: ClippingRectangle {
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
                Text {
                    visible: micSlider.pressed
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 30
                    }
                    color: "black"
                    text: Math.trunc(Audio.defaultInput?.audio.volume * 100)
                }
            }
        }

        handle: Rectangle {
            x: micSlider.visualPosition * (micSlider.availableWidth - width)
            height: 20
            width: 20
            radius: 20
            color: "transparent"
        }
        onMoved: {
            Audio.defaultInput.audio.volume = value;
        }
    }

    Slider {
        id: volumeSlider
        value: Audio.defaultOutput?.audio.volume
        from: 0
        to: 1
        stepSize: 0.01
        live: true
        anchors {
            top: parent.top
            topMargin: 20
            left: parent.left
            leftMargin: 70
            right: parent.right
            rightMargin: 70
        }
        background: ClippingRectangle {
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

                Text {
                    visible: volumeSlider.pressed
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 30
                    }
                    color: "black"
                    text: Math.trunc(Audio.defaultOutput?.audio.volume * 100)
                }
            }
        }

        handle: Rectangle {
            x: volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
            height: 20
            width: 20
            radius: 10
            color: "transparent"
        }
        onMoved: {
            Audio.defaultOutput.audio.volume = value;
        }
    }

    Rectangle {
        id: volumeMuteButton
        implicitHeight: 30
        implicitWidth: 30
        radius: 30
        anchors {
            right: volumeSlider.left
            leftMargin: 20
            left: parent.left
            rightMargin: 20
            top: parent.top
            topMargin: 20
        }

        color: Audio.defaultOutput?.audio.volume === 0 || Audio.defaultOutput?.audio.muted ? "#55967373" : "#770000"
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }

        Text {
            anchors.centerIn: parent
            text: Audio.defaultOutput?.audio.volume === 0 || Audio.defaultOutput?.audio.muted ? "󰝟" : "󰕾"
            font.pixelSize: 24
            color: Audio.defaultOutput?.audio.volume === 0 || Audio.defaultOutput?.audio.muted ? "#967373" : "#000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        MouseArea {
            id: volumeMuteArea
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: Audio.toggleOutputMute()
        }
    }

    Rectangle {
        id: micMuteButton
        implicitHeight: 30
        implicitWidth: 30
        radius: 30
        anchors {
            right: micSlider.left
            leftMargin: 20
            left: parent.left
            rightMargin: 20
            bottom: parent.bottom
            bottomMargin: 20
        }
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }

        color: Audio.defaultInput?.audio.volume === 0 || Audio.defaultInput?.audio.muted ? "#55967373" : "#770000"

        Text {
            anchors.centerIn: parent
            text: Audio.defaultInput?.audio.volume === 0 || Audio.defaultInput?.audio.muted ? "󰍭" : "󰍬"
            font.pixelSize: 24
            color: Audio.defaultInput?.audio.volume === 0 || Audio.defaultInput?.audio.muted ? "#967373" : "#000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        MouseArea {
            id: micMuteArea
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: Audio.toggleInputMute()
        }
    }
}
