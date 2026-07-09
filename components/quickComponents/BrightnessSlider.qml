import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services
import qs.components
import qs.theme

ClippingRectangle {
    id: brightRec
    color: Colors.transground2
    border {
        width: 2
        color: Colors.color3
    }
    property real fontSize
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        RowLayout {
            Text {
                id: display
                text: `Display`
                Layout.leftMargin: brightRec.fontSize / 2
                Layout.alignment: Qt.AlignVCenter
                color: Colors.foreground
                font.pixelSize: brightRec.fontSize
                font.weight: 600
            }
            Seperator {
                implicitHeight: brightRec.fontSize
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                id: bright
                text: `${Brightness.brightness}%`
                Layout.alignment: Qt.AlignVCenter
                color: Colors.foreground
                font.pixelSize: brightRec.fontSize
                font.weight: 600
            }
        }
        Slider {
            id: micSlider
            value: Brightness.brightness
            from: 0
            to: 100
            stepSize: 0.01
            live: true
            implicitHeight: brightRec.fontSize * 2
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
                        id: symbol
                        text: "󰖨"
                        font.pixelSize: brightRec.fontSize * 1.2
                        font.weight: 800
                        font.family: "FiraCode NerdFont"
                        color: Colors.background
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: brightRec.fontSize
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
                Brightness.setBrightness(value);
            }
        }
    }
}
