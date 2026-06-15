import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.theme
import qs.components.notiComponents

PopupWindow {
    id: notiCenter
    color: "transparent"
    property bool isOpen: false
    property real fontSize
    onIsOpenChanged: {
        if (isOpen === true) {
            visible = true;
        } else {
            visible = false;
        }
    }
    HyprlandFocusGrab {
        active: notiCenter.isOpen
        windows: [notiCenter]
        onCleared: {
            closeAnim.start();
        }
    }
    SequentialAnimation {
        id: closeAnim
        NumberAnimation {
            target: notiRec
            property: "y"
            to: notiRec.height
            duration: 250
            easing.type: Easing.OutQuad
        }
        ScriptAction {
            script: {
                notiCenter.isOpen = false;
            }
        }
    }

    anchor {
        edges: Edges.Left | Edges.Bottom
        gravity: Edges.Top | Edges.Right
    }
    ClippingRectangle {
        color: "transparent"
        radius: notiRec.radius
        anchors.fill: parent
        ClippingRectangle {
            id: notiRec
            anchors.horizontalCenter: parent.horizontalCenter
            implicitHeight: parent.height
            implicitWidth: parent.width
            radius: 10
            color: Colors.transground3
            border {
                width: 2
                color: Colors.color3
            }
            y: notiCenter.isOpen ? 0 : height
            Behavior on y {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutQuad
                }
            }
            NotiList {
                fontSize: notiCenter.fontSize
                anchors.margins: 10
                anchors {
                    top: parent.top
                    right: parent.right
                    left: parent.left
                    bottom: inter.top
                }
            }
            ClippingRectangle {
                id: inter
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                    left: parent.left
                }
                color: Colors.transground2
                implicitHeight: notiCenter.fontSize * 2
                radius: height / 3
                Text {
                    id: date
                    text: Time.date
                    color: Colors.color10
                    font.pixelSize: notiCenter.fontSize * 1.1
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: notiCenter.fontSize / 2
                    }
                }
                ClippingRectangle {
                    id: clearRec
                    color: area.containsMouse ? "#AA333333" : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    implicitHeight: parent.height * 0.7
                    radius: height / 3
                    implicitWidth: clear.width + height / 2
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: notiCenter.fontSize / 2
                    }
                    MouseArea {
                        id: area
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: NotiServer.clearNotifications()
                    }
                    Text {
                        id: clear
                        text: "  Clear All (" + NotiServer.items.count + ")"
                        color: area.containsMouse ? Colors.color12 : Colors.color10
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                        anchors.centerIn: parent
                        font.pixelSize: notiCenter.fontSize*0.8
                    }
                }
            }
        }
    }
}
