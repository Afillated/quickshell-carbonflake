pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import qs.services
import qs.components

Rectangle {
    id: lockRoot
    color: "#000000"

    ScreencopyView {
        id: lockBG
        captureSource: Quickshell.screens[0]
        anchors.fill: parent

        property int blurSize
        live: false
        layer.enabled: true
        layer.effect: FastBlur {
            source: lockBG
            radius: lockBG.blurSize
        }
    }

    ParallelAnimation {
        id: lockAnim
        running: LockContext.locked === true
        NumberAnimation {
            target: lockBG
            property: "blurSize"
            from: 0
            to: 64
            duration: 250
            easing.type: Easing.InCirc
        }
        NumberAnimation {
            target: date
            property: "opacity"
            from: 0
            to: 1
            duration: 400
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: time
            property: "opacity"
            duration: 400
            from: 0
            to: 1
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: username
            property: "opacity"
            duration: 400
            from: 0
            to: 1
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: passwordArea
            property: "opacity"
            duration: 400
            from: 0
            to: 1
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: nowBar
            property: "opacity"
            duration: 400
            from: 0
            to: 1
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: notiToggle
            property: "opacity"
            duration: 400
            from: 0
            to: 1
            easing.type: Easing.OutQuad
        }
    }

    SequentialAnimation {
        id: unlockAnim
        running: LockContext.showSuccess === true
        ParallelAnimation {
            NumberAnimation {
                target: date
                property: "opacity"
                from: 1
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: time
                property: "opacity"
                duration: 250
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: username
                property: "opacity"
                duration: 250
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: passwordArea
                property: "opacity"
                duration: 250
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: nowBar
                property: "opacity"
                duration: 250
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: notiToggle
                property: "opacity"
                duration: 250
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: lockBG
                property: "blurSize"
                from: 64
                to: 0
                duration: 250
                easing.type: Easing.InCirc
            }
            // NumberAnimation {
            //     target: lockBG
            //     property: "opacity"
            //     from: 1
            //     to: 0
            //     duration: 250
            //     easing.type: Easing.InCirc
            // }
        }
        ScriptAction {
            script: {
                LockContext.locked = false;
            }
        }
    }
    Text {
        id: date
        text: Time.date
        anchors {
            bottom: time.top
            horizontalCenter: time.horizontalCenter
        }
        color: "#967373"
        font {
            family: "Comfortaa"
            pixelSize: 40
            weight: 500
        }
    }
    Text {
        id: time
        text: Time.time
        font {
            family: "Comfortaa"
            pixelSize: 120
            weight: 500
        }
        color: "#967373"
        renderType: Text.NativeRendering
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: username.top
            bottomMargin: 200
        }
    }
    Label {
        id: username
        text: Username.user
        font {
            family: "Comfortaa"
            pixelSize: 28
        }

        color: "#967373"
        renderType: Text.NativeRendering
        anchors {
            bottom: passwordArea.top
            bottomMargin: 10
            horizontalCenter: passwordArea.horizontalCenter
        }
    }

    ClippingRectangle {
        id: passwordArea
        implicitWidth: 400
        implicitHeight: 60
        radius: 12
        color: "transparent"
        border {
            color: LockContext.unlockInProgress ? "orange" : "#960000"
            width: 3
            Behavior on color {
                ColorAnimation {
                    duration: 250
                    easing.type: Easing.OutQuad
                }
            }
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 350
        }
        TextInput {
            id: passwordInput
            anchors.fill: parent
            anchors.margins: 10
            enabled: !LockContext.unlockInProgress
            echoMode: TextInput.Password
            inputMethodHints: Qt.ImhSensitiveData
            text: LockContext.currentText
            onTextEdited: {
                LockContext.currentText = text;
            }
            onAccepted: LockContext.tryUnlock()
            focus: true
            color: "#967373"
            horizontalAlignment: Text.AlignHCenter
            cursorVisible: false
            font.pixelSize: 20
            font.family: "Firacode Mono Nerd Font"
            selectionColor: "#88960000"
            selectedTextColor: "#967373"
            renderType: Text.NativeRendering
            Keys.onEscapePressed: {
                passwordInput.text = "";
            }
            cursorDelegate: Rectangle {
                visible: false
            }
        }
        Text {
            text: "Incorrect Password"
            visible: LockContext.showFailure
            anchors.centerIn: parent
            color: "#967373"
            opacity: LockContext.showFailure ? 0.6 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InCirc
                }
            }
            font.pixelSize: 20
            font.family: "Comfortaa"
        }
    }

    Rectangle {
        id: nowBar // I said it lol
        color: "#33000000"
        anchors {
            bottom: parent.bottom
            bottomMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        border {
            color: "#960000"
            width: 3
        }
        implicitHeight: 60
        implicitWidth: 250
        radius: 12
        visible: MprisPlayers.activePlayer

        ClippingRectangle {
            id: imageRec
            radius: 12
            implicitHeight: 40
            implicitWidth: 40
            color: "transparent"
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                margins: 10
            }
            Image {
                id: trackArt
                source: qsTr(MprisPlayers.activePlayer?.trackArtUrl || "")
                anchors.fill: parent
                width: 40
                height: 40
                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: if (nowBar.visible === true) {
                        expandAnim.start();
                    }
                    cursorShape: nowBar.opacity != 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
        }
        RowLayout {
            id: songDetails

            anchors {
                left: imageRec.right
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 8
                leftMargin: 8
            }

            Text {
                id: titleArtist
                text: MprisPlayers.activePlayer?.trackTitle
                Layout.alignment: Qt.AlignHCenter
                color: "#967373"
                Layout.maximumWidth: 180
                elide: Text.ElideRight
                font {
                    family: "Comfortaa"
                    pixelSize: 15
                    weight: 700
                }
            }
        }
        RowLayout {
            id: songControls
            spacing: 12
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                horizontalCenter: songDetails.horizontalCenter
            }
            Text {
                id: rewindButton
                text: ""
                color: if (rewindArea.containsMouse && MprisPlayers.activePlayer?.canGoPrevious) {
                    return "#960000";
                } else if (!MprisPlayers.activePlayer?.canGoPrevious) {
                    return "#262626";
                } else {
                    return "#967373";
                }

                font {
                    family: "Firacode Mono Nerd Font"
                    pixelSize: 16
                }

                MouseArea {
                    id: rewindArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: MprisPlayers.activePlayer?.canGoNext ? Qt.PointingHandCursor : Qt.ForbiddenCursor
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
                text: {
                    if (MprisPlayers.activePlayer?.playbackState === MprisPlaybackState.Playing) {
                        return "";
                    } else if (MprisPlayers.activePlayer?.position === MprisPlayers.activePlayer?.length && !MprisPlayers.activePlayer?.canGoNext) {
                        return "";
                    } else {
                        return "";
                    }
                }
                color: if (pauseArea.containsMouse && MprisPlayers.activePlayer?.canTogglePlaying) {
                    return "#960000";
                } else if (!MprisPlayers.activePlayer?.canTogglePlaying) {
                    return "#262626";
                } else {
                    return "#967373";
                }

                font {
                    family: "Firacode Mono Nerd Font"
                    pixelSize: 16
                }

                MouseArea {
                    id: pauseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: MprisPlayers.activePlayer?.canTogglePlaying ? Qt.PointingHandCursor : Qt.ForbiddenCursor
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
                color: if (forwardArea.containsMouse && MprisPlayers.activePlayer?.canGoNext) {
                    return "#960000";
                } else if (!MprisPlayers.activePlayer?.canGoNext) {
                    return "#262626";
                } else {
                    return "#967373";
                }

                font {
                    family: "Firacode Mono Nerd Font"
                    pixelSize: 16
                }

                MouseArea {
                    id: forwardArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: MprisPlayers.activePlayer?.canGoPrevious ? Qt.PointingHandCursor : Qt.ForbiddenCursor
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

    Playing {
        id: player3
        opacity: 0
        visible: false
        color: "#33000000"
        anchors {
            bottom: nowBar.bottom
            horizontalCenter: nowBar.horizontalCenter
        }
        implicitHeight: 60
        implicitWidth: 250
        radius: 12
        appOpacity: 0
        imageOpacity: 0
        progressBarOpacity: 0
        progressOpacity: 0
        songControlsOpacity: 0
        songDetailsOpacity: 0
        lengthOpacity: 0
        border {
            color: "#960000"
            width: 3
        }
        Rectangle {
            anchors.fill: player3.imageCircle
            z: -1
            color: "transparent"
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                anchors.fill: parent
                onClicked: if (nowBar.visible === false) {
                    minimiseAnim.start();
                }
            }
        }
    }

    SequentialAnimation {
        id: expandAnim
        ScriptAction {
            script: {
                player3.visible = true;
                player3.opacity = 1;
                nowBar.border.color = "transparent";
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: player3
                property: "implicitHeight"
                from: 60
                to: 200
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "implicitWidth"
                from: 250
                to: 460
                duration: 250
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: player3
                property: "appOpacity"
                from: 0
                to: 1
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "imageOpacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "songDetailsOpacity"
                from: 0
                to: 1
                duration: 600
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "songControlsOpacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "progressBarOpacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "progressOpacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "lengthOpacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: nowBar
                property: "opacity"
                from: 1
                to: 0
                duration: 100
                easing.type: Easing.OutQuad
            }
        }

        ScriptAction {
            script: {
                nowBar.visible = false;
            }
        }
    }

    SequentialAnimation {
        id: minimiseAnim
        ScriptAction {
            script: {
                nowBar.visible = true;
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: player3
                property: "implicitHeight"
                to: 60
                from: 200
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "implicitWidth"
                to: 250
                from: 460
                duration: 250
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: player3
                property: "appOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "imageOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "songDetailsOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "songControlsOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "progressBarOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "progressOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: player3
                property: "lengthOpacity"
                to: 0
                from: 1
                duration: 100
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: nowBar
                property: "opacity"
                to: 1
                from: 0
                duration: 400
                easing.type: Easing.OutQuad
            }
        }

        ScriptAction {
            script: {
                player3.visible = false;
                nowBar.border.color = "#960000";
            }
        }
    }

    Rectangle {
        id: notiToggle
        radius: 8
        implicitHeight: 100
        implicitWidth: 20
        color: area7.containsMouse ? "#E6000000" : "transparent"
        border {
            color: "#960000"
            width: 2
        }
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }
        MouseArea {
            id: area7
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: {
                if (notificationcenter.x < 0) {
                    notificationcenter.x = notiToggle.x + notiToggle.width + 20;
                } else if (notificationcenter.x > 0) {
                    notificationcenter.x = -notificationcenter.width;
                }
            }
        }
    }
    LockNoti {
        id: notificationcenter
        x: -notificationcenter.width
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 500
        implicitHeight: 900
        Behavior on x {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
    }
}
