import Quickshell
import QtQuick
import Quickshell.Hyprland
import qs.components

PopupWindow {
    id: playerPanel
    implicitHeight: 200
    implicitWidth: 460
    color: "transparent"
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 250
        }
    }
    HyprlandFocusGrab {
        active: playerPanel.visible
        windows: [playerPanel]
        onCleared: {
            closeAnim.start();
        }
    }
    SequentialAnimation {
        id: closeAnim
        ParallelAnimation {
            NumberAnimation {
                target: playRec
                property: "implicitWidth"
                duration: 250
                easing.type: Easing.OutQuad
                from: playerPanel.implicitWidth
                to: 0
            }
            NumberAnimation {
                target: playRec
                property: "appOpacity"
                duration: 150
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: playRec
                property: "imageOpacity"
                duration: 150
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: playRec
                property: "songDetailsOpacity"
                duration: 150
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: playRec
                property: "songControlsOpacity"
                duration: 150
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
        }
        ScriptAction {
            script: {
                playerPanel.visible = false;
            }
        }
    }

    anchor {
        edges: Edges.Left | Edges.Bottom
        gravity: Edges.Top | Edges.Right
    }

    Playing {
        id: playRec
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        implicitHeight: parent.height
        implicitWidth: playerPanel.visible ? parent.width : 0
        appOpacity: playerPanel.visible ? 1 : 0
        imageOpacity: playerPanel.visible ? 1 : 0
        songDetailsOpacity: playerPanel.visible ? 1 : 0
        songControlsOpacity: playerPanel.visible ? 1 : 0
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
        Behavior on appOpacity {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
        Behavior on imageOpacity {
            NumberAnimation {
                duration: 350
                easing.type: Easing.OutQuad
            }
        }
        Behavior on songDetailsOpacity {
            NumberAnimation {
                duration: 350
                easing.type: Easing.OutQuad
            }
        }
        Behavior on songControlsOpacity {
            NumberAnimation {
                duration: 350
                easing.type: Easing.OutQuad
            }
        }
    }
}
