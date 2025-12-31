import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.services
import qs.components
import Quickshell.Io

PopupWindow {
    id: quickPanel
    implicitHeight: 800
    implicitWidth: 500

    color: "transparent"
    HyprlandFocusGrab {
        active: quickPanel.visible
        windows: [quickPanel]
        onCleared: {
            quickPanel.visible = false;
        }
    }

    anchor {
        edges: Edges.Right | Edges.Bottom
        gravity: Edges.Top | Edges.Left
    }

    Rectangle {
        id: quickRec
        anchors.fill: parent
        color: "#E6000000"
        radius: 15
        border {
            width: 1.5
            color: "#960000"
        }

        opacity: quickPanel.visible ? 1 : 0
        scale: quickPanel.visible ? 1 : 0.9

        Behavior on opacity {
            NumberAnimation {
                duration: 100
                easing.type: Easing.OutQuad
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 100
                easing.type: Easing.OutQuad
            }
        }

        Text {
            id: fullName
            text: Username.user
            color: "#967373"
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                left: parent.left
                leftMargin: 16
            }
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
            }
        }
        // RowLayout {
        //     id: sessionBar
        //     anchors {
        //         bottom: parent.bottom
        //         bottomMargin: 10
        //         right: parent.right
        //         rightMargin: 16
        //     }
        //     spacing: 10

        //     Button {
        //         id: lockButton
        //         implicitWidth: 24
        //         implicitHeight: 24
        //         background: Rectangle {
        //             anchors.fill: parent
        //             color: "transparent"
        //         }
        //         Text {
        //             text: ""
        //             color: lockArea.containsMouse ? "#960000" : "#967373"
        //             anchors.centerIn: parent
        //             font.pixelSize: 18
        //             Behavior on color {
        //                 ColorAnimation {
        //                     duration: 250
        //                 }
        //             }
        //         }
        //         MouseArea {
        //             id: lockArea
        //             anchors.fill: parent
        //             hoverEnabled: true
        //             cursorShape: Qt.PointingHandCursor
        //             onClicked: Quickshell.execDetached(["hyprlock"]);
        //         }
        //     }
        //     Button {
        //         id: shutdownButton
        //         implicitWidth: 24
        //         implicitHeight: 24
        //         background: Rectangle {
        //             anchors.fill: parent
        //             color: "transparent"
        //         }
        //         Text {
        //             text: "󰐥"
        //             color: shutdownArea.containsMouse ? "#960000" : "#967373"
        //             anchors.centerIn: parent
        //             font.pixelSize: 20
        //             Behavior on color {
        //                 ColorAnimation {
        //                     duration: 250
        //                 }
        //             }
        //         }
        //         MouseArea {
        //             id: shutdownArea
        //             anchors.fill: parent
        //             hoverEnabled: true
        //             cursorShape: Qt.PointingHandCursor
        //             onClicked: Quickshell.execDetached(["systemctl", "poweroff"]);
        //         }
        //     }

        //     Button {
        //         id: rebootButton
        //         implicitWidth: 24
        //         implicitHeight: 24
        //         background: Rectangle {
        //             anchors.fill: parent
        //             color: "transparent"
        //         }
        //         Text {
        //             id: reboot
        //             text: "󰜉"
        //             color: rebootArea.containsMouse ? "#960000" : "#967373"
        //             Behavior on color {
        //                 ColorAnimation {
        //                     duration: 250
        //                 }
        //             }
        //             anchors.centerIn: parent
        //             font.pixelSize: 20
        //         }
        //         MouseArea {
        //             id: rebootArea
        //             anchors.fill: parent
        //             hoverEnabled: true
        //             cursorShape: Qt.PointingHandCursor
        //             onClicked: Quickshell.execDetached(["systemctl", "reboot"]);
        //         }
        //     }

        //     Button {
        //         id: logoutButton
        //         implicitWidth: 24
        //         implicitHeight: 24
        //         background: Rectangle {
        //             anchors.fill: parent
        //             color: "transparent"
        //         }
        //         Text {
        //             text: "󰍃"
        //             color: logoutArea.containsMouse ? "#960000" : "#967373"
        //             anchors.centerIn: parent
        //             font.pixelSize: 20
        //             Behavior on color {
        //                 ColorAnimation {
        //                     duration: 250
        //                 }
        //             }
        //         }
        //         MouseArea {
        //             id: logoutArea
        //             anchors.fill: parent
        //             hoverEnabled: true
        //             cursorShape: Qt.PointingHandCursor
        //             onClicked: Quickshell.execDetached(["uwsm", "stop"]);
        //         }
        //     }
        // }
        SessionBar {
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                right: parent.right
                rightMargin: 16
            }
        }
    }
}
