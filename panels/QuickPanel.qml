import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.services
import qs.components

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
    }
    
}
