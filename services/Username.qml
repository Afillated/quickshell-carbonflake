pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: username
    property string user
    property string uptime

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
    Process {
        running: true
        onRunningChanged: if (!running) running = true
        command: ["sh", "-c", "cat /proc/uptime | cut -d ' ' -f1"]
        stdout: StdioCollector {
            onStreamFinished: username.uptime = username.formatSeconds(Math.floor(this.text.trim()));
        }
    }
}
