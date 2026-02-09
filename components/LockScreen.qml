import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
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
    }
    ShaderEffectSource {
        id: bgTexture
        sourceItem: lockBG
        anchors.fill: parent
    }

    FastBlur {
        id: bgBlur
        anchors.fill: parent
        source: bgTexture
        radius: 0

        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: 0.1
        }
    }

    NumberAnimation {
        target: bgBlur
        property: "radius"
        from: 0
        to: 128
        duration: 250
        easing.type: Easing.InCirc
        running: LockContext.locked === true
    }
    Text {
        id: date
        text: Time.date
        anchors {
            bottom: time.top
            bottomMargin: -10
            horizontalCenter: time.horizontalCenter
        }
        color: "#967373"
        font {
            family: "Noto Sans Bold"
            pixelSize: 40
            weight: 500
        }

    }
    Text {
        id: time
        text: Time.time
        font {
            family: "Noto Sans Bold"
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
            family: "Firacode Mono Nerd Font"
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
            onTextEdited: LockContext.currentText = text
            onAccepted: LockContext.tryUnlock()
            focus: true
            color: "#967373"
            horizontalAlignment: Text.AlignHCenter
            cursorVisible: false
            font.pixelSize: 20
            font.family: "Firacode Mono Nerd Font"
            selectionColor: "transparent"
            selectedTextColor: "#967373"
            renderType: Text.NativeRendering
        }

        Text {
            text: "Incorrect Password"
            visible: LockContext.showFailure
            anchors.centerIn: parent
            color: "#967373"
            opacity: 0.6
            font.pixelSize: 18
            font.family: "Firacode Mono Nerd Font"
        }
    }
}
