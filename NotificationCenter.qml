import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.services


PopupWindow {
    id: notificationcenter
    implicitHeight: 800
    implicitWidth: 500
    color: "transparent"

    HyprlandFocusGrab {
        active: notificationcenter.visible
        windows : [ notificationcenter ]
        onCleared: {
            notificationcenter.visible = false
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
        // just for testing
        // Rectangle {
        //     id: test
        //     color: "black"
        //     radius: 10
        //     border {
        //         width: 1.5
        //         color: "#960000"
        //     }
        //     anchors {
        //         top: notificationRec.top
        //         topMargin: 20
        //         right: notificationRec.right
        //         rightMargin: 20
        //         left: notificationRec.left
        //         leftMargin: 20
        //     }

        //     implicitHeight: 100
        //     Text {
        //         text: "test"
        //         anchors.verticalCenter: test.verticalCenter 
        //         anchors.horizontalCenter: test.horizontalCenter
        //         color: "#AA0000"
        //     }
        // }
    }
    
}
