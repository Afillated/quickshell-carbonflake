pragma Singleton

import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Services.Pam

Singleton {
    id: root
    signal unlocked
    signal failed

    property string currentText: ""
    property bool unlockInProgress: false
    property bool showFailure: false
    property bool showSuccess: false
    property bool locked: false

    onCurrentTextChanged: showFailure = false
    onLockedChanged: {
        if (root.locked === true) {
            root.showSuccess = false;
        }
    }

    function tryUnlock() {
        if (currentText === "")
            return;
        root.unlockInProgress = true;
        pam.start();
    }

    PamContext {
        id: pam

        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText);
            }
        }
        onCompleted: result => {
            if (result == PamResult.Success) {
                root.unlocked();
                // root.locked = false;
                root.showSuccess = true;
                root.currentText = "";
            } else {
                root.currentText = "";
                root.showFailure = true;
            }
            root.unlockInProgress = false;
        }
    }
}
