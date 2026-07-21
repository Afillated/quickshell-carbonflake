import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.theme
import qs.services
import qs.components

ClippingRectangle {
    id: audioRec
    color: Colors.transground2
    border {
        width: 2
        color: Colors.color3
    }
    property real fontSize
    signal volOpen
    signal micOpen
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: audioRec.fontSize / 2
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            RowLayout {
                Layout.fillWidth: true
                Text {
                    id: out
                    text: `Output Volume`
                    Layout.leftMargin: audioRec.fontSize / 2
                    Layout.alignment: Qt.AlignVCenter
                    color: Colors.foreground
                    font.pixelSize: audioRec.fontSize
                    font.weight: 600
                }
                Seperator {
                    implicitHeight: audioRec.fontSize
                    Layout.alignment: Qt.AlignVCenter
                }
                Text {
                    id: volume
                    text: Math.round(Audio.defaultOutput?.audio.volume * 100) + "%"
                    Layout.alignment: Qt.AlignVCenter
                    color: Colors.foreground
                    font.pixelSize: audioRec.fontSize
                    font.weight: 600
                }
            }
            RowLayout {
                Layout.fillWidth: true
                spacing: audioRec.fontSize / 2
                Slider {
                    id: volSlider
                    Layout.fillWidth: true
                    value: parseFloat(Audio.defaultOutput?.audio.volume)
                    from: 0
                    to: 1
                    stepSize: 0.01
                    live: true
                    implicitHeight: audioRec.fontSize * 2
                    implicitWidth: parent.width
                    background: ClippingRectangle {
                        radius: height / 3
                        color: "#55967373"
                        clip: true
                        Rectangle {
                            width: volSlider.visualPosition * parent.width
                            height: parent.height
                            radius: height / 3
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: Colors.color13
                                }
                                GradientStop {
                                    position: 1.0
                                    color: Colors.color10
                                }
                            }
                            Text {
                                id: symbol
                                text: Audio.defaultOutput?.audio.muted || Audio.defaultOutput?.audio.volume === 0 ? "󰝟" : "󰕾"
                                font.pixelSize: audioRec.fontSize * 1.4
                                font.weight: 800
                                font.family: "FiraCode NerdFont"
                                color: volSlider.value < 0.11 ? Colors.foreground : Colors.background
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                    left: parent.left
                                    leftMargin: audioRec.fontSize
                                }
                            }
                        }
                    }
                    handle: Rectangle {
                        x: volSlider.visualPosition * (volSlider.availableWidth - width)
                        height: parent.height
                        width: height
                        radius: height / 3
                        color: "transparent"
                    }
                    onMoved: {
                        Audio.defaultOutput.audio.volume = value;
                    }
                }

                ClippingRectangle {
                    id: volButton
                    color: area.containsMouse ? Colors.color10 : "#55967373"
                    implicitHeight: volSlider.height
                    implicitWidth: height
                    radius: height / 3
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    MouseArea {
                        id: area
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: audioRec.volOpen()
                    }
                    Text {
                        anchors.centerIn: parent
                        font.family: "FiraCode NerdFont"
                        font.pixelSize: audioRec.fontSize * 1.2
                        text: ""
                        color: area.containsMouse ? Colors.background : Colors.foreground
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }
        }
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            RowLayout {
                Layout.fillWidth: true
                Text {
                    id: mic
                    text: `Input Volume`
                    Layout.leftMargin: audioRec.fontSize / 2
                    Layout.alignment: Qt.AlignVCenter
                    color: Colors.foreground
                    font.pixelSize: audioRec.fontSize
                    font.weight: 600
                }
                Seperator {
                    implicitHeight: audioRec.fontSize
                    Layout.alignment: Qt.AlignVCenter
                }
                Text {
                    id: inVol
                    text: Math.round(Audio.defaultInput?.audio.volume * 100) + "%"
                    Layout.alignment: Qt.AlignVCenter
                    color: Colors.foreground
                    font.pixelSize: audioRec.fontSize
                    font.weight: 600
                }
            }
            RowLayout {
                Layout.fillWidth: true
                spacing: audioRec.fontSize / 2
                Slider {
                    id: micSlider
                    Layout.fillWidth: true
                    value: parseFloat(Audio.defaultInput?.audio.volume)
                    from: 0
                    to: 1.52
                    stepSize: 0.01
                    live: true
                    implicitHeight: audioRec.fontSize * 2
                    implicitWidth: parent.width
                    background: ClippingRectangle {
                        radius: height / 3
                        color: "#55967373"
                        clip: true
                        Rectangle {
                            width: micSlider.visualPosition * parent.width
                            height: parent.height
                            radius: height / 3
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: Colors.color13
                                }
                                GradientStop {
                                    position: 1.0
                                    color: Colors.color10
                                }
                            }
                            Text {
                                id: symbol2
                                text: Audio.defaultInput?.audio.muted || Audio.defaultInput?.audio.volume === 0 ? "󰍭" : "󰍬"
                                font.pixelSize: audioRec.fontSize * 1.2
                                font.weight: 800
                                font.family: "FiraCode NerdFont"
                                color: micSlider.value < 0.11 ? Colors.foreground : Colors.background
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                    left: parent.left
                                    leftMargin: audioRec.fontSize
                                }
                            }
                        }
                    }
                    handle: Rectangle {
                        x: micSlider.visualPosition * (micSlider.availableWidth - width)
                        height: parent.height
                        width: height
                        radius: height / 3
                        color: "transparent"
                    }
                    onMoved: {
                        Audio.defaultInput.audio.volume = value;
                    }
                }

                ClippingRectangle {
                    id: micButton
                    color: area2.containsMouse ? Colors.color10 : "#55967373"
                    implicitHeight: micSlider.height
                    implicitWidth: height
                    radius: height / 3
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    MouseArea {
                        id: area2
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: audioRec.micOpen()
                    }
                    Text {
                        anchors.centerIn: parent
                        font.family: "FiraCode NerdFont"
                        font.pixelSize: audioRec.fontSize * 1.2
                        text: ""
                        color: area2.containsMouse ? Colors.background : Colors.foreground
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }
        }
    }
}
