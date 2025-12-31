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
        command: ["sh", "-c", "~/.config/quickshell/services/scripts/get_fullname.sh $(whoami)"]
        stdout: StdioCollector {
            onStreamFinished: username.user = this.text
        }
    }
}
