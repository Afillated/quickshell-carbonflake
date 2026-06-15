import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services
import qs.theme

FloatingWindow {
    id: polWindow
    title: "Polkit"
    implicitWidth: 300
    implicitHeight: 200
    visible: PolkitService.active && PolkitService.registered
    color: "transparent"
    onVisibleChanged: {
        passwordInput.text = "";
        if (!visible)
            PolkitService.authFlow?.cancelAuthenticationRequest();
    }
    Shortcut {
        sequence: "Escape"
        enabled: polWindow.visible
        onActivated: {
            passwordInput.text = "";
        }
    }
    Shortcut {
        sequence: "Shift + Escape"
        enabled: polWindow.visible
        onActivated: {
            PolkitService.authFlow?.cancelAuthenticationRequest();
            passwordInput.text = "";
        }
    }
    Rectangle {
        id: polRec
        anchors.fill: parent
        color: Colors.transground
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
                    color: Colors.color15
                    text: String(PolkitService.authFlow?.message)
                    wrapMode: Text.WordWrap
                }
            }
            Text {
                id: supMessage
                text: String(PolkitService.authFlow?.supplementoryMessage)
                opacity: PolkitService.active ? Boolean(PolkitService.authFlow?.suppplementoryMessage) : false
                visible: opacity > 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
                color: Colors.color15
            }
            Text {
                id: prompt
                text: String(PolkitService.authFlow?.inputPrompt)
                opacity: PolkitService.active ? Boolean(PolkitService.authFlow?.inputPrompt) : false
                visible: opacity > 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
                color: Colors.color15
                Layout.bottomMargin: -20
            }

            ClippingRectangle {
                id: passwordArea
                Layout.fillWidth: true
                implicitHeight: 40
                radius: 12
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                border {
                    color: Colors.color3
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
                    enabled: !failAnim.running
                    echoMode: PolkitService.authFlow?.responseVisible ? TextInput.Normal : TextInput.Password
                    inputMethodHints: Qt.ImhSensitiveData
                    onAccepted: {
                        PolkitService.authFlow.submit(passwordInput.text);
                        passwordInput.text = "";
                        failAnim.start();
                    }
                    focus: true
                    color: Colors.color15
                    horizontalAlignment: Text.AlignHCenter
                    cursorVisible: false
                    font.pixelSize: 16
                    font.family: "Firacode Mono Nerd Font"
                    selectionColor: "#88960000"
                    selectedTextColor: Colors.color15
                    renderType: Text.NativeRendering
                    cursorDelegate: Rectangle {
                        visible: false
                    }
                    HoverHandler {
                        cursorShape: Qt.IBeamCursor
                    }
                }

                Text {
                    id: faile
                    text: "Incorrect Password"
                    anchors.centerIn: parent
                    color: Colors.color15
                    opacity: 0
                    SequentialAnimation {
                        id: failAnim
                        PauseAnimation {
                            duration: 500
                        }
                        NumberAnimation {
                            target: faile
                            property: "opacity"
                            duration: 250
                            to: 0.8
                            easing.type: Easing.InCirc
                        }
                        PauseAnimation {
                            duration: 1000
                        }
                        NumberAnimation {
                            target: faile
                            property: "opacity"
                            duration: 250
                            to: 0
                            easing.type: Easing.OutCirc
                        }
                    }
                }
            }
        }
    }
}
