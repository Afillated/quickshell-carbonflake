import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.panels

RowLayout {
    id: centerRow
    Layout.alignment: Qt.AlignVCenter
    spacing: Math.round(fontSize / 2)
    signal clicked
    property real fontSize
    property real barRecHeight
    property real barRecWidth
    property real barHeight
    property real barWidth
    property var window
    property bool barPinned: true

    PinButton {
        id: button
        barPinned: centerRow.barPinned
        iconSize: Math.round(centerRow.barRecHeight * 0.55)
        implicitHeight: centerRow.barRecHeight * 0.6
        onClicks: centerRow.clicked()
    }
    Seperator {
        id: sep1
        implicitHeight: parent.barRecHeight * 0.6
    }
    HyprlandWorkspaces {
        id: hyprWS
        butSize: Math.round(centerRow.barRecHeight * 0.6)
        fontSize: centerRow.fontSize
    }
    Launcher {
        id: launcher
        implicitHeight: centerRow.barHeight * 8
        initialHeight: centerRow.barHeight
        implicitWidth: centerRow.barWidth / 3
        fontSize: centerRow.fontSize
        anchor {
            window: centerRow.window
            rect.x: centerRow.barWidth / 2 - launcher.implicitWidth / 2
            rect.y: -centerRow.barHeight * 12
        }
    }
}
