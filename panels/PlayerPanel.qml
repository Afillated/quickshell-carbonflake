import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick

PopupWindow {
    id: playerPanel
    color: "transparent"
    property bool isOpen: false
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
            target: test
            property: "x"
            to: -test.width
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
        color: "transparent"
        radius: test.radius
        anchors.fill: parent
        Rectangle {
            id: test
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: parent.height
            implicitWidth: parent.width
            radius: 10
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
