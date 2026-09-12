pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import QtQuick
import "types" as Types

Singleton {
    id: root
    readonly property bool available: Bluetooth.defaultAdapter
    property int scanTimeout: 60 * 1000
    readonly property bool enabled: Bluetooth.defaultAdapter?.enabled
    readonly property Types.Bluetooth indicators: Types.Bluetooth {}
    readonly property bool isConnected: devices.some(device => device.connected)
    readonly property var devices: {
        const devModel = Bluetooth.devices;
        if (!devModel)
            return [];
        const all = [...devModel.values];
        const paired = all.filter(d => d.paired);
        const available = all.filter(d => !d.paired);
        return [...paired, ...available];
    }
    readonly property bool scanning: Bluetooth.defaultAdapter?.discovering
    readonly property string status: {
        if (!enabled)
            return indicators.powerOff;
        if (Bluetooth.devices?.values.filter(device => device.connected).length > 0)
            return indicators.connected;
        return indicators.powerOn;
    }
    function toggleDefault() {
        if (Bluetooth.defaultAdapter) {
            if (Bluetooth.defaultAdapter.state === BluetoothAdapterState.Blocked) {
                forceEnable();
            } else {
                Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
            }
        }
    }
    function toggleScaning() {
        if (Bluetooth.defaultAdapter) {
            Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
        }
    }

    Timer {
        id: scanTimer
        interval: root.scanTimeout
        running: Bluetooth.defaultAdapter?.discovering ?? false
        repeat: false
        onTriggered: {
            if (Bluetooth.defaultAdapter) {
                Bluetooth.defaultAdapter.discovering = false;
            }
        }
    }

    function forceEnable() {
        if (Bluetooth.defaultAdapter) {
            Quickshell.execDetached(["pkexec", "rfkill", "unblock", "bluetooth"]);
        }
    }
}
