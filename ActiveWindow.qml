import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland

Rectangle {
    id: activeWindowRec
    color: "#E6000000"
    radius: 15
    border {
        color: "#960000"
        width: 1.5
    }

    implicitHeight: 30
    implicitWidth: appId.contentWidth + 20

    Text {
        id: appId
        anchors.centerIn: parent
        text: ToplevelManager?.activeToplevel == null || Hyprland.focusedWorkspace?.toplevels.values.length == 0 ? "  desktop" : ToplevelManager.activeToplevel.appId   
        color: "#C10000"
        font {
            family: "Firacode Mono Nerd Font"
            pixelSize: 20
        }
        
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 25
            easing.type: Easing.Linear
        }
    }
    
}
