import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick

import qs.components.playerComponents

PopupWindow {
    id: playerPanel
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
        active: playerPanel.isOpen
        windows: [playerPanel]
        onCleared: {
            closeAnim.start();
        }
    }
    SequentialAnimation {
        id: closeAnim
        NumberAnimation {
            target: player
            property: "x"
            to: -player.width
            duration: 200
            easing.type: Easing.OutQuad
        }
        ScriptAction {
            script: {
                playerPanel.isOpen = false;
            }
        }
    }

    anchor {
        edges: Edges.Left | Edges.Bottom
        gravity: Edges.Top | Edges.Right
    }
    ClippingRectangle {
        id: radRec
        color: "transparent"
        radius: player.radius
        anchors.fill: parent
        Player {
            id: player
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: parent.height
            implicitWidth: parent.width
            radius: 10
            fontSize: playerPanel.fontSize
            x: playerPanel.isOpen ? 0 : -width
            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
