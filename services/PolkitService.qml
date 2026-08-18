pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Polkit

Singleton {
    id: root
    property var authFlow: polkit.flow
    property bool registered: polkit?.isRegistered
    property bool active: polkit?.isActive
    PolkitAgent {
        id: polkit
    }
}

