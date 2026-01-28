pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import qs.services

Rectangle {
    id: playingRec
    color: "#E6000000"
    radius: 15
    border {
        width: 1.5
        color: "#CC960000"
    }
    function getIcon() {
        if (DesktopEntries.byId(MprisPlayers.activePlayer.desktopEntry))
            return Quickshell.iconPath(DesktopEntries.byId(MprisPlayers.activePlayer.desktopEntry).icon);
        return null;
    }
    property alias appOpacity: appInfo.opacity
    property alias imageOpacity: imageRec.opacity
    property alias songDetailsOpacity: songDetails.opacity
    property alias songControlsOpacity: songControls.opacity

    RowLayout {
        id: appInfo
        Layout.fillWidth: true
        anchors {
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 10
        }
        Loader {
            active: true
            sourceComponent: Image {
                anchors.centerIn: parent
                sourceSize: Qt.size(20, 20)
                source: playingRec.getIcon()
            }
        }
        Rectangle {
            color: "transparent"
            implicitWidth: appName.width
            implicitHeight: appName.height
            Text {
                id: appName
                text: MprisPlayers.playerName
                Layout.alignment: Qt.AlignCenter

                color: appButton.containsMouse ? "#960000" : "#967373"
                font {
                    family: "Firacode Mono Nerd Font"
                    pixelSize: 18
                    weight: 500
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }
            }
            MouseArea {
                id: appButton
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: MprisPlayers.activePlayer.raise()
            }
        }
    }

    ClippingRectangle {
        id: imageRec
        radius: 10
        width: 150
        color: "transparent"
        anchors {
            top: appInfo.bottom
            bottom: parent.bottom
            left: parent.left
            margins: 10
        }
        Image {
            id: trackArt
            source: qsTr(MprisPlayers.activePlayer.trackArtUrl || "")
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }
    }

    ColumnLayout {
        id: songDetails
        spacing: 0
        anchors {
            left: imageRec.right
            leftMargin: 10
            top: appInfo.bottom
            topMargin: 10
        }
        Text {
            id: trackTitle
            text: MprisPlayers.activePlayer.trackTitle
            color: "#967373"
            Layout.maximumWidth: 250
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 18
                weight: 600
            }
            elide: Text.ElideRight
        }
        Text {
            id: trackArtist
            text: MprisPlayers.activePlayer.trackArtist
            color: "#967373"
            Layout.maximumWidth: 250
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 14
                weight: 500
            }
            elide: Text.ElideRight
        }

        Text {
            id: trackAlbum
            text: MprisPlayers.activePlayer.trackAlbum
            color: "#967373"
            Layout.maximumWidth: 250
            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 14
                weight: 500
            }
            elide: Text.ElideRight
        }
    }

    RowLayout {
        id: songControls
        spacing: 14
        anchors {
            bottom: parent.bottom
            left: imageRec.right
            leftMargin: 110
            bottomMargin: 10
        }
        Text {
            id: rewindButton
            text: ""
            color: if (rewindArea.containsMouse && MprisPlayers.activePlayer.canGoPrevious) {
                return "#960000";
            } else if (!MprisPlayers.activePlayer.canGoPrevious) {
                return "#262626";
            } else {
                return "#967373";
            }

            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
            }

            MouseArea {
                id: rewindArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: MprisPlayers.activePlayer.canGoNext ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                onClicked: MprisPlayers.activePlayer.previous()
            }
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }

        Text {
            id: playPauseButton
            text: MprisPlayers.activePlayer.playbackState === MprisPlaybackState.Playing ? "" : ""
            color: if (pauseArea.containsMouse && MprisPlayers.activePlayer.canTogglePlaying) {
                return "#960000";
            } else if (!MprisPlayers.activePlayer.canTogglePlaying) {
                return "#262626";
            } else {
                return "#967373";
            }

            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
            }

            MouseArea {
                id: pauseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: MprisPlayers.activePlayer.canTogglePlaying ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                onClicked: MprisPlayers.activePlayer.togglePlaying()
            }
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }
        Text {
            id: forwardButton
            text: ""
            color: if (forwardArea.containsMouse && MprisPlayers.activePlayer.canGoNext) {
                return "#960000";
            } else if (!MprisPlayers.activePlayer.canGoNext) {
                return "#262626";
            } else {
                return "#967373";
            }

            font {
                family: "Firacode Mono Nerd Font"
                pixelSize: 20
            }

            MouseArea {
                id: forwardArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: MprisPlayers.activePlayer.canGoPrevious ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                onClicked: MprisPlayers.activePlayer.next()
            }
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }
    }
}
