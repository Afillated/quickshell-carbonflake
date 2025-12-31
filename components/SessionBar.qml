import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell.Io

RowLayout {
    id: sessionBar
    spacing: 10

    Button {
        id: lockButton
        implicitWidth: 24
        implicitHeight: 24
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            text: ""
            color: lockArea.containsMouse ? "#960000" : "#967373"
            anchors.centerIn: parent
            font.pixelSize: 18
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }
        MouseArea {
            id: lockArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Quickshell.execDetached(["hyprlock"])
        }
    }
    Button {
        id: shutdownButton
        implicitWidth: 24
        implicitHeight: 24
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            text: "󰐥"
            color: shutdownArea.containsMouse ? "#960000" : "#967373"
            anchors.centerIn: parent
            font.pixelSize: 20
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }
        MouseArea {
            id: shutdownArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
        }
    }

    Button {
        id: rebootButton
        implicitWidth: 24
        implicitHeight: 24
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            id: reboot
            text: "󰜉"
            color: rebootArea.containsMouse ? "#960000" : "#967373"
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
            anchors.centerIn: parent
            font.pixelSize: 20
        }
        MouseArea {
            id: rebootArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Quickshell.execDetached(["systemctl", "reboot"])
        }
    }

    Button {
        id: logoutButton
        implicitWidth: 24
        implicitHeight: 24
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            text: "󰍃"
            color: logoutArea.containsMouse ? "#960000" : "#967373"
            anchors.centerIn: parent
            font.pixelSize: 20
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }
        MouseArea {
            id: logoutArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Quickshell.execDetached(["uwsm", "stop"])
        }
    }
}
