pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

import qs.services
import qs.theme

ClippingRectangle {
    id: nowRec
    signal click
    property real fontSize
    property real maxWidth
    implicitWidth: MprisPlayers.activePlayer ? Math.ceil(nowPlaying.width + height / 2) : 0
    opacity: MprisPlayers.activePlayer ? 1 : 0
    visible: opacity > 0

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            nowRec.click();
        }
    }
    color: area.containsMouse ? "#33AAAAAA" : "transparent"
    radius: height / 3
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    function getIcon() {
        if (DesktopEntries.byId(MprisPlayers.selectedPlayer?.desktopEntry))
            return Quickshell.iconPath(DesktopEntries.byId(MprisPlayers.selectedPlayer?.desktopEntry).icon);
        return 'image://icon/music';
    }

    RowLayout {
        id: nowPlaying
        anchors.centerIn: parent
        spacing: nowRec.fontSize / 2
        Layout.alignment: Qt.AlignCenter
        Layout.maximumWidth: nowRec.maxWidth

        Loader {
            active: true
            Layout.alignment: Qt.AlignCenter
            sourceComponent: Image {
                anchors.centerIn: parent
                sourceSize: Qt.size(nowRec.fontSize * 0.7, nowRec.fontSize * 0.7)
                source: nowRec.getIcon()
            }
        }
        Text {
            id: title
            text: MprisPlayers.activePlayer?.trackTitle ? MprisPlayers.activePlayer?.trackTitle : "No Title"
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: nowRec.maxWidth
            color: area.containsMouse ? Colors.color12 : Colors.color15
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            font {
                pixelSize: nowRec.fontSize
                weight: 500
            }
            elide: Text.ElideRight
        }
    }
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutQuad
        }
    }
}
