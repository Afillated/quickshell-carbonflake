import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import qs.services

FloatingWindow {
    id: polWindow
    title: "Polkit"
    // placeholder values, depends on how you set you set it on your compositer, it is advised to window rules to prevent unwanted tiling
    implicitWidth: 300
    implicitHeight: 200
    visible: PolkitService.active && PolkitService.registered
    color: "transparent"
    Shortcut {
        sequence: "Escape"
        enabled: polWindow.visible
        onActivated: {
            PolkitService.authFlow?.cancelAuthenticationRequest();
            passwordInput.text = "";
        }
    }
    Rectangle {
        id: polRec
        anchors.fill: parent
        color: "#AA000000"
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10
            RowLayout {
                IconImage {
                    id: icon
                    visible: PolkitService.active ? Boolean(PolkitService.authFlow?.iconName) : false
                    source: Quickshell.iconPath(String(PolkitService.authFlow?.iconName))
                    implicitSize: 50
                }
                Text {
                    id: message
                    Layout.maximumWidth: 350
                    color: "#967373"
                    text: String(PolkitService.authFlow?.message)
                    wrapMode: Text.WordWrap
                    font.family: "Firacode Mono Nerd Font"
                }
            }
            Text {
                id: supMessage
                text: String(PolkitService.authFlow?.supplementoryMessage)
                visible: PolkitService.active ? Boolean(PolkitService.authFlow?.suppplementoryMessage) : false
                color: "#967373"
                font.family: "Firacode Mono Nerd Font"
            }
            Text {
                id: prompt
                text: PolkitService.authFlow?.failed > 0 && passwordInput.text == "" ? "Incorrect Password" : String(PolkitService.authFlow?.inputPrompt)
                visible: PolkitService.active ? Boolean(PolkitService.authFlow?.inputPrompt) : false
                color: "#967373"
                Layout.bottomMargin: -20
                font.family: "Firacode Mono Nerd Font"
            }

            ClippingRectangle {
                id: passwordArea
                Layout.fillWidth: true
                implicitHeight: 40
                radius: 12
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                border {

                    color: "#960000"
                    width: 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.OutQuad
                        }
                    }
                }
                TextInput {
                    id: passwordInput
                    anchors.fill: parent
                    anchors.margins: 10
                    echoMode: PolkitService.authFlow?.responseVisible ? TextInput.Normal : TextInput.Password
                    inputMethodHints: Qt.ImhSensitiveData
                    onAccepted: {
                        PolkitService.authFlow.submit(passwordInput.text);
                        passwordInput.text = "";
                    }
                    focus: true
                    color: "#967373"
                    horizontalAlignment: Text.AlignHCenter
                    cursorVisible: false
                    font.pixelSize: 16
                    font.family: "Firacode Mono Nerd Font"
                    selectionColor: "#88960000"
                    selectedTextColor: "#967373"
                    renderType: Text.NativeRendering
                    cursorDelegate: Rectangle {
                        visible: false
                    }
                    HoverHandler {
                        cursorShape: Qt.IBeamCursor
                    }
                }
            }
        }
    }
}
