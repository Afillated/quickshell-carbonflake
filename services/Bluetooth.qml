pragma Singleton

import Quickshell
// import Quickshell.Io
import Quickshell.Bluetooth
import QtQuick
import "types" as Types

Singleton {
    id: root

    readonly property Types.Bluetooth indicators: Types.Bluetooth {}
    readonly property string status: {
    
        if ([BluetoothAdapterState.Blocked, BluetoothAdapterState.Disabled].includes(Bluetooth.defaultAdapter?.state))
            return indicators.powerOff;
        if (Bluetooth.devices?.values.filter(device => device.connected).length > 0)
            return indicators.connected;
        return indicators.powerOn;
    }
}
