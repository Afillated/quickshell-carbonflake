pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
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
}
