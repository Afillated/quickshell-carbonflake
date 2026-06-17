import Quickshell.Wayland
import QtQuick

import qs.services
import qs.components.lockComponents

WlSessionLock {
    id: lockScreen
    locked: LockContext.locked
    WlSessionLockSurface {
        id: lockSurface
        LockScreen {
            screen: lockSurface.screen
            anchors.fill: parent
        }
    }
}
