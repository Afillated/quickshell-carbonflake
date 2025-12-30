pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: username
    Process {
        running: true
        command: ["sh", "-c", "~/.comfig/quickshell/services/get_fullname.sh $(whoami)"]
        stdout: StdioCollector {
            onStreamFinished: console.log(`line read: ${this.text}`)
        }
    }
}
