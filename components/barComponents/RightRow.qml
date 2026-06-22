import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.theme
import qs.panels

RowLayout {
    id: rightRow
    Layout.alignment: Qt.AlignVCenter
    spacing: Math.round(fontSize / 2)
    layoutDirection: Qt.RightToLeft
    property real fontSize
    property real barRecHeight
    property real barRecWidth
    property real barHeight
    property real barWidth
    property var window
    property bool stayOpen: quickPanel.isOpen
    SysStatus {
        id: status
        fontSize: rightRow.fontSize
        implicitHeight: parent.barRecHeight * 0.6
        onClick: {
            quickPanel.isOpen = !quickPanel.isOpen;
        }
    }
    Seperator {
        id: sep1
        implicitHeight: parent.barRecHeight * 0.6
    }
    ActiveWindow {
        id: activeWin
        implicitHeight: parent.barRecHeight * 0.6
        fontSize: rightRow.fontSize
        maxWidth: rightRow.barWidth / 8
    }
    QuickPanel {
        id: quickPanel
        implicitHeight: rightRow.barHeight * 14
        implicitWidth: rightRow.barWidth / 3.5
        fontSize: rightRow.fontSize
        anchor {
            window: rightRow.window
            rect.x: rightRow.barWidth - 10
            rect.y: 0
        }
    }
}
