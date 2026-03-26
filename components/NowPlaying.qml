pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.services
import Quickshell.Services.Mpris

ClippingRectangle {
    id: nowRec
    color: "#E6000000"
    radius: 15
    clip: true
    border {
        color: "#CC960000"
        width: 3 / 2
    }
    implicitHeight: 30
    implicitWidth: MprisPlayers.activePlayer ? nowPlaying.width : 0

    function getIcon() {
        if (DesktopEntries.byId(MprisPlayers.selectedPlayer?.desktopEntry))
            return Quickshell.iconPath(DesktopEntries.byId(MprisPlayers.selectedPlayer.desktopEntry).icon);
        return null;
    }

    RowLayout {
        id: nowPlaying
        anchors.centerIn: parent
        spacing: 8
        Layout.alignment: Qt.AlignCenter
        Layout.maximumWidth: 200

        Loader {
            active: true
            Layout.leftMargin: 10
            Layout.alignment: Qt.AlignCenter
            sourceComponent: Image {
                anchors.centerIn: parent
                sourceSize: Qt.size(20, 20)
                source: nowRec.getIcon()
            }
        }
        Text {
            id: title
            text: MprisPlayers.activePlayer?.trackTitle ?  MprisPlayers.activePlayer?.trackTitle : "No Title" 
            Layout.alignment: Qt.AlignCenter
            Layout.rightMargin: 12
            Layout.maximumWidth: 200

            color: "#C10000"
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 18
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

    ParallelAnimation {
        id: playAnim
        running: MprisPlayers.activePlayer
        NumberAnimation {
            target: nowRec
            property: "implicitWidth"
            from: 0
            to: nowPlaying.width
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: nowPlaying
            property: "opacity"
            from: 0
            to: 1
        }
    }

    ParallelAnimation {
        id: pauseAnim
        running: !MprisPlayers.activePlayer
        NumberAnimation {
            target: nowRec
            property: "implicitWidth"
            to: 0
            from: nowPlaying.width
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: nowPlaying
            property: "opacity"
            to: 0
            from: 1
        }
    }
}
