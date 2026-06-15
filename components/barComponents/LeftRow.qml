import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.panels

RowLayout {
    id: leftRow
    Layout.alignment: Qt.AlignVCenter
    spacing: Math.round(fontSize / 2)
    property real fontSize
    property real barRecHeight
    property real barRecWidth
    property real barHeight
    property real barWidth
    property var window
    property bool stayOpen: player.isOpen || notiCenter.isOpen
    ClockWidget {
        id: clock
        onClick: {
            notiCenter.isOpen = !notiCenter.isOpen;
        }
        fontSize: parent.fontSize
        recHeight: leftRow.barRecHeight * 0.6
    }

    Seperator {
        id: sep1
        implicitHeight: nowBar.visible ? parent.barRecHeight * 0.6 : 0
        visible: implicitHeight > 0
        Behavior on implicitHeight {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InQuad
            }
        }
    }

    NowPlaying {
        id: nowBar
        implicitHeight: parent.barRecHeight * 0.6
        fontSize: parent.fontSize
        maxWidth: parent.barWidth / 8
        onClick: {
            player.isOpen = !player.isOpen;
        }
    }
    PlayerPanel {
        id: player
        implicitHeight: leftRow.barHeight * 3.8
        implicitWidth: leftRow.barWidth / 4
        anchor {
            window: leftRow.window
            rect.x: 10
            rect.y: 0
        }
    }
    NotificationCenter {
        id: notiCenter
        implicitHeight: leftRow.barHeight * 14
        implicitWidth: leftRow.barWidth / 3.5
        fontSize: leftRow.fontSize
        anchor {
            window: leftRow.window
            rect.x: 10
            rect.y: 0
        }
    }
}
