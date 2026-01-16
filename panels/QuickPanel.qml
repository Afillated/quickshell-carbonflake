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
            closeAnim.start();
        }
    }

    anchor {
        edges: Edges.Right | Edges.Bottom
        gravity: Edges.Top | Edges.Left
    }

    SequentialAnimation {
        id: closeAnim
        ParallelAnimation {
            NumberAnimation {
                target: quickRec
                property: "implicitHeight"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: fullName
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: sessionBar
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: volumeRockers
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
        ScriptAction {
            script: {
                quickPanel.visible = false;
            }
        }
    }

    Rectangle {
        id: quickRec
        anchors.bottom: parent.bottom
        color: "#E6000000"
        radius: 15
        border {
            width: 1.5
            color: "#CC960000"
        }

        implicitHeight: quickPanel.visible ? parent.height : 0
        implicitWidth: parent.width

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }

        VolumeMenu {
            id: volumeRockers
            opacity: quickPanel.visible ? 1 : 0
            anchors {
                right: parent.right
                left: parent.left
                bottom: fullName.top
                margins: 10
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }

        Text {
            id: fullName
            text: Username.user
            color: "#967373"
            opacity: quickPanel.visible ? 1 : 0
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
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }
        SessionBar {
            id: sessionBar
            opacity: quickPanel.visible ? 1 : 0
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                right: parent.right
                rightMargin: 16
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }
    }
}
