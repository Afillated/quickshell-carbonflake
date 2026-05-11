pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick
import "types" as Types

Singleton {
    id: root
    readonly property bool enabled: Bluetooth.defaultAdapter.enabled
    readonly property Types.Bluetooth indicators: Types.Bluetooth {}
    readonly property var devices: {
        const devModel = Bluetooth.devices;
        if (!devModel)
            return [];
        const all = [...devModel.values];
        const paired = all.filter(d => d.paired);
        const available = all.filter(d => !d.paired);
        return [...paired, ...available];
    }
    readonly property bool scanning: Bluetooth.defaultAdapter.discovering
    readonly property string status: {
        if (!enabled)
            return indicators.powerOff;
        if (Bluetooth.devices?.values.filter(device => device.connected).length > 0)
            return indicators.connected;
        return indicators.powerOn;
    }
    function toggleDefault() {
        if (Bluetooth.defaultAdapter) {
            Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
        }
    }
    function toggleScaning() {
        if (Bluetooth.defaultAdapter) {
            Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
        }
    }
}
