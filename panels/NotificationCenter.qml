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
            closeAnim.start();
        }
    }
    SequentialAnimation {
        id: closeAnim
        ParallelAnimation {
            NumberAnimation {
                target: notificationRec
                property: "implicitHeight"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: notidate
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: clearButton
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: noNoti
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: notiList
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player2
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
        ScriptAction {
            script: {
                notificationcenter.visible = false;
            }
        }
    }

    anchor {
        edges: Edges.Left | Edges.Bottom
        gravity: Edges.Top | Edges.Right
    }
    Rectangle {
        id: notificationRec
        anchors.bottom: parent.bottom
        color: "#E6000000"
        radius: 15
        clip: true
        border {
            width: 1.5
            color: "#CC960000"
        }
        implicitHeight: notificationcenter.visible ? parent.height : 0
        implicitWidth: parent.width
        Behavior on implicitHeight {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }

        Text {
            id: notidate
            text: Time.date
            color: "#967373"
            opacity: notificationcenter.visible ? 1 : 0
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
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }

        Rectangle {
            id: clearButton
            color: "transparent"
            implicitHeight: 25
            implicitWidth: clearAllText.width + 20
            radius: 10
            opacity: notificationcenter.visible ? 1 : 0
            anchors {
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin: 12
            }

            MouseArea {
                id: clearall
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: NotiServer.clearNotifications()
            }
            Text {
                id: clearAllText
                text: "  Clear All (" + NotiServer.items.count + ")"
                color: clearall.containsMouse ? "#960000" : "#967373"
                anchors.centerIn: parent
                font.family: "Firacode Mono Nerd Font"
                font.pixelSize: 14
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }
        ColumnLayout {
            id: noNoti
            opacity: notificationcenter.visible ? 1 : 0
            anchors.centerIn: parent
            visible: NotiServer.items.count === 0
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "No notifications"
                color: "#967373"
                font {
                    pixelSize: 20
                    family: "Firacode Mono Nerd Font"
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }
        Playing {
            id: player2
            anchors {
                bottom: notidate.top
                right: parent.right
                left: parent.left
                margins: 10
            }
            implicitHeight: 200
            opacity: notificationcenter.visible && player2.visible ? 1 : 0
            visible: MprisPlayers.activePlayer
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }

        ListView {
            id: notiList
            spacing: 10
            model: NotiServer.items
            orientation: ListView.Vertical
            clip: true
            opacity: notificationcenter.visible ? 1 : 0
            anchors {
                bottom: player2.top
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
