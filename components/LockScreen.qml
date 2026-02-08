import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import qs.components

Rectangle {
    id: lockRoot
    color: "#000000"

    Label {
        id: username
        text: Username.user
        font.pixelSize: 40
        color: "#967373"
        anchors {
            bottom: passwordArea.top
            bottomMargin: 20
            horizontalCenter: passwordArea.horizontalCenter
        }
    }

    ClippingRectangle {
        id: passwordArea
        implicitWidth: 400
        implicitHeight: 50
        radius: 12
        color: "transparent"
        border {
            color: LockContext.unlockInProgress ? "orange" : "#960000"
            width: 2
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 300
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
            font.family: "Firacode Nerd font Mono"
        }
        Text {
            text: "Incorrect Password"
            visible: LockContext.showFailure
            anchors.centerIn: parent
            color: "#967373"
            opacity: 0.6
        }
    }
}
