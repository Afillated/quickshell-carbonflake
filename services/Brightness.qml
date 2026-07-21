pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property int brightness: rawBrightness / maxBrightness * 100
    property int rawBrightness: parseInt(current.text())
    property int maxBrightness: parseInt(max.text())

    function setBrightness(value) {
        Quickshell.execDetached(["sh", "-c", `brightnessctl set ${value}%`]);
    }

    FileView {
        id: max
        path: Qt.resolvedUrl("/sys/class/backlight/amdgpu_bl1/max_brightness")
    }

    FileView {
        id: current
        path: Qt.resolvedUrl("/sys/class/backlight/amdgpu_bl1/brightness")
        watchChanges: true
        onFileChanged: {
            reload();
        }
    }
}
