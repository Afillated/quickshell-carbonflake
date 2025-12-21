pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.services
import qs.components

PopupWindow {
    id: notificationcenter
    implicitHeight: 800
    implicitWidth: 500
    color: "transparent"

    HyprlandFocusGrab {
        active: notificationcenter.visible
        windows: [notificationcenter]
        onCleared: {
            notificationcenter.visible = false;
        }
    }

    anchor {
        edges: Edges.Left | Edges.Bottom
        gravity: Edges.Top | Edges.Right
    }

    Rectangle {
        id: notificationRec
        anchors.fill: parent
        color: "#E6000000"
        radius: 15
        border {
            width: 1.5
            color: "#960000"
        }

        Text {
            id: notidate
            text: Time.date
            color: "#967373"
            anchors {
                left: notificationRec.left
                leftMargin: 10
                bottom: parent.bottom
                bottomMargin: 10
            }
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
            }
        }

        Rectangle {
            id: clearButton
            color: "transparent"
            border {
                width: 1.5
                color: "#960000"
            }
            implicitHeight: 25
            implicitWidth: 60
            radius: 15
            anchors {
                right: parent.right
                rightMargin: 16
                bottom: parent.bottom
                bottomMargin: 10
            }

            MouseArea {
                id: clearall
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: NotiServer.clearNotifications();
            }
        }

        ListView {
            id: notiList
            spacing: 50
            model: NotiServer.items
            orientation: ListView.Vertical
            clip: true
            anchors {
                bottom: clearButton.top
                bottomMargin: 10
                top: notificationRec.top
                topMargin: 10
                right: notificationRec.right
                left: notificationRec.left
                rightMargin: 10
                leftMargin: 10
            }

            delegate: NotiCard {
                required property var modelData
                required property int index
                width: notiList.width

                noti: modelData
            }

            add: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "height"
                        from: 0
                        duration: 250
                        easing.type: Easing.OutBack
                    }
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        property: "scale"
                        from: 0.8
                        to: 1
                        duration: 250
                        easing.type: Easing.OutBack
                    }
                }
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "height"
                        to: 0
                        duration: 200
                        easing.type: Easing.InCubic
                    }
                    NumberAnimation {
                        property: "opacity"
                        to: 0
                        duration: 150
                        easing.type: Easing.InCubic
                    }
                    NumberAnimation {
                        property: "scale"
                        to: 0.8
                        duration: 200
                        easing.type: Easing.InCubic
                    }
                }
            }

            displaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
