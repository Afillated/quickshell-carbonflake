pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: username
    property string user
    property string uptime: {
        let seconds = parseFloat(cat.text().split(" ")[0]);
        return username.formatSeconds(Math.floor(seconds));
    }

    Process {
        running: true
        command: ["sh", "-c", "getent passwd $USER | cut -d: -f5 | cut -d, -f1"]
        stdout: StdioCollector {
            onStreamFinished: username.user = this.text.trim()
        }
    }

    function formatSeconds(secs) {
        var minutes = Math.floor(secs / 60);
        var seconds = secs % 60;
        var hours = Math.floor(minutes / 60);
        minutes %= 60;
        var pad = function (num) {
            return (num < 10 ? '0' : '') + num;
        };
        if (hours > 0) {
            return pad(hours) + ':' + pad(minutes) + ':' + pad(seconds);
        } else {
            return pad(minutes) + ':' + pad(seconds);
        }
    }

    FileView {
        id: cat
        path: Qt.resolvedUrl("/proc/uptime")
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: cat.reload()
    }
}
