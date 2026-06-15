import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.theme

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
    SysStatus {
        id: status
        fontSize: rightRow.fontSize
        implicitHeight: parent.barRecHeight * 0.6
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
}
