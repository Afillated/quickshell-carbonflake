pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: username
    property string user

    Process {
        running: true
        command: ["sh", "-c", "getent passwd $USER | cut -d: -f5 | cut -d, -f1"]
        stdout: StdioCollector {
            onStreamFinished: username.user = this.text.trim()
        }
    }
}
