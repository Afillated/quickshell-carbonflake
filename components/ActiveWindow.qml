pragma ComponentBehavior: Bound

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
    implicitWidth: activeWindow.width 

    property bool showDesktop: Hyprland.focusedWorkspace?.toplevels.values.length == 0 || ToplevelManager.activeToplevel == null
    property bool showIcon: !activeWindowRec.showDesktop && (DesktopEntries.byId(ToplevelManager.activeToplevel?.appId) || DesktopEntries.byId(ToplevelManager.activeToplevel?.title))

    function getIcon() {
        if (!ToplevelManager.activeToplevel)
            return null;
        const toplevel = ToplevelManager.activeToplevel;
        if (DesktopEntries.byId(toplevel.appId))
            return Quickshell.iconPath(DesktopEntries.byId(toplevel.appId).icon);
        const title = DesktopEntries.byId(toplevel.title);
        if (title)
            return Quickshell.iconPath(title.icon);
        const heuristicLookup = DesktopEntries.heuristicLookup(toplevel.title);
        if (heuristicLookup)
            return Quickshell.iconPath(heuristicLookup.icon);
        return null;
    }

    
    RowLayout {
        id: activeWindow
        spacing: 8
        Layout.alignment: Qt.AlignCenter
        
        Loader {
            active: activeWindowRec.showIcon
            Layout.leftMargin: 10
            sourceComponent: Image {
                anchors.centerIn: parent
                sourceSize: Qt.size(20, 20)
                source: activeWindowRec.getIcon()
            }
        }

        Text {
            id: appId
            Layout.alignment: Qt.AlignCenter
            Layout.rightMargin: 12
            text: ToplevelManager?.activeToplevel == null || Hyprland.focusedWorkspace?.toplevels.values.length == 0 ? "desktop" : ToplevelManager.activeToplevel.appId
            color: "#C10000"
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
            }
            Behavior on text {
                SequentialAnimation{
                    NumberAnimation{
                        property: "opacity"
                        target: appId
                        to: 0
                        easing.type: Easing.OutQuad
                        duration: 1
                    }
                    NumberAnimation{
                        property: "opacity"
                        target: appId
                        to: 1
                        easing.type: Easing.OutQuad
                        duration: 1
                    }
                }
            }
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 25
            easing.type: Easing.Linear
        }
    }
}
