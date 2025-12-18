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
    implicitWidth: activeWindow.width + 20

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
        spacing: 10
        Layout.alignment: Qt.AlignCenter
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        
        Loader {
            active: activeWindowRec.showIcon
            Layout.leftMargin: 10
            sourceComponent: Image {
                anchors.centerIn: parent
                sourceSize: Qt.size(22, 22)
                source: activeWindowRec.getIcon()
            }
        }

        Rectangle{
            id: hi
            implicitHeight: 18
            implicitWidth: 2
            color: "#960000"
        }

        Text {
            id: appId
            Layout.alignment: Qt.AlignCenter
            Layout.leftMargin: 4
            text: ToplevelManager?.activeToplevel == null || Hyprland.focusedWorkspace?.toplevels.values.length == 0 ? "desktop" : ToplevelManager.activeToplevel.appId
            color: "#C10000"
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
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
