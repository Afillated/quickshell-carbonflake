import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
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
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }
    property real fontSize
    property bool clickEnable: true
    // Surely there is a better way to do this
    property string outIcon: Audio.defaultOutput?.audio.muted || Audio.defaultOutput?.audio.volume === 0 ? "󰝟" : "󰕾"
    PwNodeLinkTracker {
        id: outLink
        node: Audio.defaultOutput
    }
    property string inIcon: Audio.defaultInput?.audio.muted || Audio.defaultInput?.audio.volume === 0 ? "󰍭" : "󰍬"
    PwNodeLinkTracker {
        id: inLink
        node: Audio.defaultInput
    }
    RowLayout {
        id: sysRow
        anchors.centerIn: parent
        spacing: sysRec.fontSize / 3
        layoutDirection: Qt.RightToLeft
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
        BatteryIcon {
            implicitHeight: sysRec.height * 0.8
            implicitWidth: sysRec.fontSize * 2
            visible: Battery.isAvailable
            fontSize: sysRec.fontSize
        }
        Text {
            id: powerProfile
            Layout.alignment: Qt.AlignVCenter
            text: Battery.profileIcon
            color: area.containsMouse ? Colors.color12 : Colors.color15
            font.pixelSize: sysRec.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
        Text {
            id: mic
            Layout.alignment: Qt.AlignVCenter
            text: sysRec.inIcon
            color: area.containsMouse ? Colors.color12 : Colors.color15
            font.pixelSize: sysRec.fontSize
            opacity: inLink.linkGroups.length != 0 ? 1 : 0
            visible: opacity > 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InCirc
                }
            }
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
            opacity: outLink.linkGroups.length != 0 ? 1 : 0
            visible: opacity > 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InCirc
                }
            }
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
            opacity: Bluetooth.enabled ? 1 : 0
            visible: opacity > 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InCirc
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
        //I really gotta make a quickshell wifi serivce
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
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: sysRec.clickEnable ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: sysRec.clickEnable
        onClicked: {
            sysRec.click();
        }
    }
}
