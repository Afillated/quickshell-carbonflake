pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.theme

ClippingRectangle {
    id: playRec
    color: Colors.transground3
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    visible: MprisPlayers.activePlayer
    border {
        width: 2
        color: Colors.color3
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }
    signal imageClick
    property real fontSize
    property int playerCount: MprisPlayers.activeIndex
    function getIcon() {
        if (DesktopEntries.byId(MprisPlayers.activePlayer?.desktopEntry))
            return Quickshell.iconPath(DesktopEntries.byId(MprisPlayers.activePlayer.desktopEntry).icon);
        return null;
    }

    function formatSeconds(secs) {
        var minutes = Math.floor(secs / 60);
        var seconds = secs % 60;
        var hours = Math.floor(minutes / 60);
        minutes %= 60;

        var pad = function (num) {
            return (num < 10 ? '0' : '') + num;
        };

        if (hours > 0) {
            return pad(hours) + ':' + pad(minutes) + ':' + pad(seconds);
        } else {
            return pad(minutes) + ':' + pad(seconds);
        }
    }

    RowLayout {
        id: appInfo
        Layout.fillWidth: true
        spacing: 0
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
                sourceSize: Qt.size(playRec.fontSize * 0.7, playRec.fontSize * 0.7)
                source: playRec.getIcon()
            }
        }
        Rectangle {
            id: appNameRec
            color: appButton.containsMouse && MprisPlayers.playerList.length > 1 ? "#33AAAAAA" : "transparent"
            implicitWidth: appName.width + height / 2
            implicitHeight: appName.height
            radius: height / 3
            Text {
                id: appName
                text: MprisPlayers.playerName
                Layout.alignment: Qt.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter

                color: appButton.containsMouse && MprisPlayers.playerList.length > 1 ? Colors.color12 : Colors.color15
                font {
                    pixelSize: playRec.fontSize * 1.2
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
                cursorShape: MprisPlayers.playerList.length > 1 ? Qt.SizeVerCursor : Qt.ArrowCursor
                onWheel: {
                    if (MprisPlayers.playerList.length > 1) {
                        if (wheel.angleDelta.y > 0 && MprisPlayers.playerList.length > 1 && playRec.playerCount <= MprisPlayers.playerList.length) {
                            playRec.playerCount++;
                        } else if (wheel.angleDelta.y < 0 && MprisPlayers.playerList.length > 1 && playRec.playerCount >= MprisPlayers.playerList.length) {
                            playRec.playerCount--;
                        }
                        MprisPlayers.selectPlayer(playRec.playerCount);
                        wheel.accepted = true;
                    }
                }
            }
        }
    }

    ClippingRectangle {
        id: imageRec
        color: Colors.transground3
        radius: 10
        implicitWidth: height
        anchors {
            top: appInfo.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
        }
        Image {
            id: trackArt
            source: qsTr(MprisPlayers.activePlayer?.trackArtUrl || "")
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: LockContext.locked ? Qt.PointingHandCursor : Qt.ArrowCursor
            enabled: LockContext.locked
            onClicked: {
                playRec.imageClick();
            }
        }
    }
    ColumnLayout {
        id: songDetails
        spacing: 5
        Layout.fillWidth: true
        anchors {
            left: imageRec.right
            leftMargin: 10
            top: appInfo.bottom
            topMargin: playRec.fontSize
        }
        Text {
            id: trackTitle
            text: MprisPlayers.activePlayer?.trackTitle ? MprisPlayers.activePlayer?.trackTitle : "No Title"
            color: Colors.color10
            Layout.maximumWidth: playRec.width / 2
            font {
                pixelSize: playRec.fontSize * 1.2
                weight: 600
            }
            elide: Text.ElideRight
        }
        Text {
            id: trackArtist
            text: MprisPlayers.activePlayer?.trackArtist ? MprisPlayers.activePlayer?.trackArtist : "No Artist"
            color: Colors.color10
            Layout.maximumWidth: playRec.width / 2
            font {
                pixelSize: playRec.fontSize
                weight: 500
            }
            elide: Text.ElideRight
        }

        Text {
            id: trackAlbum
            text: MprisPlayers.activePlayer?.trackAlbum ? MprisPlayers.activePlayer?.trackAlbum : " "
            color: Colors.color10
            Layout.maximumWidth: playRec.width / 2
            font {
                pixelSize: playRec.fontSize
                weight: 500
            }
            elide: Text.ElideRight
        }
    }

    PlayerProgress {
        id: progressBar
        anchors {
            left: imageRec.right
            top: songDetails.bottom
            right: parent.right
            margins: 10
            topMargin: playRec.fontSize * 1.5
        }
        implicitHeight: playRec.fontSize / 3
    }
    Text {
        id: progress
        text: playRec.formatSeconds(Math.floor(MprisPlayers.activePlayer?.position))
        anchors {
            top: progressBar.bottom
            topMargin: playRec.fontSize / 5
            left: progressBar.left
        }
        color: Colors.color10
        font {
            pixelSize: playRec.fontSize
            weight: 500
        }
    }
    Text {
        id: songLength
        text: playRec.formatSeconds(Math.floor(MprisPlayers.activePlayer?.length))
        anchors {
            top: progressBar.bottom
            topMargin: playRec.fontSize / 5
            right: progressBar.right
        }
        color: Colors.color10
        font {
            pixelSize: playRec.fontSize
            weight: 500
        }
    }

    PlayerControls {
        id: controls
        fontSize: playRec.fontSize * 1.25
        anchors {
            horizontalCenter: progressBar.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 10
        }
    }
}
