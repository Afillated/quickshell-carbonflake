pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property int brightness
    Process {
        running: true
        command: ["sh", "-c", "brightnessctl | grep \"Current brightness:\" | tr -s ' ' | cut -d' ' -f4 | tr -d '(%)'"]
        stdout: StdioCollector {
            onStreamFinished: root.brightness = this.text.trim()
        }
    }

    function setBrightness(value) {
        root.brightness = value;
        Quickshell.execDetached(["sh", "-c", `brightnessctl set ${value}%`]);
    }
}
