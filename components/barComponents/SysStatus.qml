import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.theme

ClippingRectangle {
    id: sysRec
    signal click
    color: area.containsMouse ? "#33AAAAAA" : "transparent"
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    radius: height / 3
    implicitWidth: sysRow.implicitWidth + sysRec.height / 2
    property real fontSize
    property string outIcon: Audio.defaultOutput?.audio.muted || Audio.defaultOutput?.audio.volume === 0 ? "󰝟" : "󰕾"
    property string inIcon: Audio.defaultInput?.audio.muted || Audio.defaultInput?.audio.volume === 0 ? "󰍭" : "󰍬"
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            sysRec.click();
        }
    }
    RowLayout {
        id: sysRow
        anchors.centerIn: parent
        spacing: sysRec.fontSize/3
        layoutDirection: Qt.RightToLeft
        BatteryIcon {
            implicitHeight: sysRec.height * 0.8
            implicitWidth: sysRec.fontSize * 2
            visible: Battery.isAvailable
            fontSize: sysRec.fontSize
        }
        Text {
            id: mic
            Layout.alignment: Qt.AlignVCenter
            text: sysRec.inIcon
            color: area.containsMouse ? Colors.color12 : Colors.color15
            font.pixelSize: sysRec.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
        Text {
            id: speaker
            Layout.alignment: Qt.AlignVCenter
            text: sysRec.outIcon
            color: area.containsMouse ? Colors.color12 : Colors.color15
            font.pixelSize: sysRec.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
        Text {
            id: blue
            Layout.alignment: Qt.AlignVCenter
            text: Bluetooth.status
            color: area.containsMouse ? Colors.color12 : Colors.color15
            font.pixelSize: sysRec.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
        Text {
            id: net
            Layout.alignment: Qt.AlignVCenter
            text: Network.status
            color: area.containsMouse ? Colors.color12 : Colors.color15
            font.pixelSize: sysRec.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
    }
}
