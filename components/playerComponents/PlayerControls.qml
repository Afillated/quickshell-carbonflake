import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services
import qs.theme

RowLayout {
    id: controls
    property real fontSize
    spacing: fontSize / 8

    Label {
        id: rewind
        text: "  "
        color: if (rewindArea.containsMouse && MprisPlayers.activePlayer?.canGoPrevious) {
            return Colors.color3;
        } else if (!MprisPlayers.activePlayer?.canGoPrevious) {
            return "#262626";
        } else {
            return "#967373";
        }
        Behavior on color {
            ColorAnimation {
                duration: 250
            }
        }
        font.pixelSize: controls.fontSize
        background: ClippingRectangle {
            id: rewindBG
            color: rewindArea.containsMouse ? "#33AAAAAA" : "transparent"
            radius: height / 3
            implicitHeight: controls.fontSize * 2
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
            MouseArea {
                id: rewindArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: Boolean(MprisPlayers.activePlayer?.canGoPrevious)
                cursorShape: MprisPlayers.activePlayer?.canGoPrevious ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: {
                    MprisPlayers.activePlayer.previous();
                }
            }
        }
    }
    Label {
        id: play
        text: {
            if (MprisPlayers.activePlayer?.playbackState === MprisPlaybackState.Playing) {
                return "  ";
            } else if (MprisPlayers.activePlayer?.position === MprisPlayers.activePlayer?.length && !MprisPlayers.activePlayer?.canGoNext) {
                return "  ";
            } else {
                return "  ";
            }
        }
        color: if (playArea.containsMouse && MprisPlayers.activePlayer?.canTogglePlaying) {
            return Colors.color3;
        } else if (!MprisPlayers.activePlayer?.canTogglePlaying) {
            return "#262626";
        } else {
            return "#967373";
        }
        Behavior on color {
            ColorAnimation {
                duration: 250
            }
        }
        font.pixelSize: controls.fontSize
        background: ClippingRectangle {
            id: playBG
            color: playArea.containsMouse ? "#33AAAAAA" : "transparent"
            radius: height / 3
            implicitHeight: controls.fontSize * 2
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
            MouseArea {
                id: playArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: Boolean(MprisPlayers.activePlayer?.canTogglePlaying)
                cursorShape: MprisPlayers.activePlayer?.canTogglePlaying ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: MprisPlayers.activePlayer.togglePlaying()
            }
        }
    }
    Label {
        id: forward
        text: "  "
        color: if (forwardArea.containsMouse && MprisPlayers.activePlayer?.canGoNext) {
            return Colors.color3;
        } else if (!MprisPlayers.activePlayer?.canGoNext) {
            return "#262626";
        } else {
            return "#967373";
        }
        Behavior on color {
            ColorAnimation {
                duration: 250
            }
        }
        font.pixelSize: controls.fontSize
        background: ClippingRectangle {
            id: forwardBG
            color: forwardArea.containsMouse ? "#33AAAAAA" : "transparent"
            radius: height / 3
            implicitHeight: controls.fontSize * 2
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
            MouseArea {
                id: forwardArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: Boolean(MprisPlayers.activePlayer?.canGoNext)
                cursorShape: MprisPlayers.activePlayer?.canGoNext ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: MprisPlayers.activePlayer.next()
            }
        }
    }
}
