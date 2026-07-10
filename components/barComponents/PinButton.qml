import Quickshell
import QtQuick

import qs.theme
import qs.services

Rectangle {
    id: pinButton
    implicitWidth: name.width * 2.5
    radius: height / 3
    signal clicks
    property bool barPinned
    property int iconSize
    MouseArea {
        id: pinArea
        anchors.fill: parent
        onClicked: {
            pinButton.clicks();
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
    color: pinArea.containsMouse ? "#33AAAAAA" : "transparent"
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
        }
    }
    Text {
        id: name
        anchors.centerIn: parent
        text: pinButton.barPinned ? "󰐄" : "󰐃"
        font.pixelSize: pinButton.iconSize
        font.family: "Firacode NerdFont"
        color: pinArea.containsMouse ? Colors.color12 : Colors.color15
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }
}
