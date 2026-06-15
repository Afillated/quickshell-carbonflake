pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.UPower

Singleton {
    property bool isAvailable: UPower.displayDevice.isLaptopBattery
    property bool isFullyCharged: UPower.displayDevice.state == UPowerDeviceState.FullyCharged
    property bool isCharging: UPower.displayDevice.state == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || UPower.displayDevice.state == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice.percentage
    property real estimatedTime: isCharging ? UPower.displayDevice.timeToFull : UPower.displayDevice.timeToEmpty

    property bool isLow: percentage <= 30 / 100
    property bool isCritical: percentage <= 15 / 100
    property bool isLowAndNotCharging: isAvailable && isLow && !isCharging
    property bool isCriticalAndNotCharging: isAvailable && isCritical && !isCharging

    property var activeProfile: PowerProfiles.profile
    property string profileIcon: {
        switch (activeProfile) {
        case PowerProfile.PowerSaver:
            return "󰌪";
        case PowerProfile.Balanced:
            return "󰘮";
        case PowerProfile.Performance:
            return "󰓅";
        default:
            print(activeProfile == PowerProfile.Performance);
            return "󰚦";
        }
    }

    function formatETA(seconds) {
        if ((seconds <= 0 || !isFinite(seconds)) && isFullyCharged)
            return "Fully Charged";

        const prefix = isCharging ? "Full in" : "Remaining";
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const remainingSeconds = Math.floor(seconds % 60);

        if (hours > 0) {
            if (minutes > 0) {
                return `${prefix}: ${hours}h ${minutes}m`;
            }
            return `${prefix}: ${hours}h`;
        }

        if (minutes > 0) {
            if (minutes >= 10 || remainingSeconds === 0) {
                return `${prefix}: ${minutes}m`;
            }
            return `${prefix}: ${minutes}m ${remainingSeconds}s`;
        }

        return `${prefix}: ${remainingSeconds}s`;
    }

    function setProfile(profile) {
        PowerProfiles.profile = profile;
    }
}

