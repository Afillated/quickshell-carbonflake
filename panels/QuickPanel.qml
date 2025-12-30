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

    // Process {
    //     running: true
    //     command: ["sh", "-c", "~/.config/quickshell/services/scripts/get_fullname.sh $(whoami)"]
    //     stdout: StdioCollector {
    //         onStreamFinished: console.log(`line read: ${this.text}`)
    //     }
    // }
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
    }
}
