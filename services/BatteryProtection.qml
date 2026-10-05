pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property bool conservationEnabled: state.text().trim() === "1"

    FileView {
        id: state
        path: "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
        watchChanges: true
        atomicWrites: false
        printErrors: true
        onFileChanged: reload()
    }

    function toggleMode() {
        state.setText(root.conservationEnabled ? "0" : "1");
        state.reload();
    }
}
