pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import qs.theme

ClippingRectangle {
    id: activeWindowRec
    color: "transparent"
    radius: height / 3
    implicitWidth: activeWindow.width + height / 2
    property real fontSize
    property real maxWidth
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
        spacing: activeWindowRec.fontSize / 2
        anchors.centerIn: parent

        Loader {
            active: activeWindowRec.showIcon
            visible: active
            sourceComponent: Image {
                anchors.centerIn: parent
                sourceSize: Qt.size(activeWindowRec.fontSize * 0.7, activeWindowRec.fontSize * 0.7)
                source: activeWindowRec.getIcon()
            }
        }

        Text {
            id: desktop
            text: ""
            font.pixelSize: activeWindowRec.fontSize
            color: Colors.color15
            visible: activeWindowRec.showDesktop
        }
        Text {
            id: appId
            Layout.alignment: Qt.AlignVCenter
            Layout.maximumWidth: activeWindowRec.maxWidth
            elide: Text.ElideRight
            text: {
                if (activeWindowRec.showDesktop) {
                    return "desktop";
                } else if (String(ToplevelManager.activeToplevel?.appId) && String(ToplevelManager.activeToplevel?.appId).length < 13 && String(ToplevelManager.activeToplevel?.appId) != "electron" && !(String(ToplevelManager.activeToplevel?.appId).includes("."))) {
                    return String(ToplevelManager.activeToplevel?.appId);
                } else {
                    return String(ToplevelManager.activeToplevel?.title);
                }
            }
            color: Colors.color15
            font {
                pixelSize: activeWindowRec.fontSize
                weight: 400
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
