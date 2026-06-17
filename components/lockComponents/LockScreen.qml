pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import qs.services
import qs.theme

Rectangle {
    id: lockRoot
    color: "#000000"
    required property ShellScreen screen
    property real fontSize: Math.round(screen?.height * 0.02)

    ScreencopyView {
        id: lockBG
        captureSource: lockRoot.screen
        anchors.fill: parent
        visible: LockContext.locked

        property int blurSize
        live: false
        layer.enabled: true
        layer.effect: FastBlur {
            source: lockBG
            radius: LockContext.locked ? lockBG.blurSize : 0
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
                target: lockBG
                property: "opacity"
                from: 0.4
                to: 0.6
                duration: 250
                easing.type: Easing.InCirc
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
                target: clock
                property: "opacity"
                duration: 400
                from: 0
                to: 1
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: date
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
                target: nowbar
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
                    target: lockBG
                    property: "opacity"
                    from: 0.6
                    to: 1
                    duration: 250
                    easing.type: Easing.InCirc
                }
                NumberAnimation {
                    target: lockBG
                    property: "blurSize"
                    from: 64
                    to: 0
                    duration: 250
                    easing.type: Easing.InCirc
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
                    target: clock
                    property: "opacity"
                    duration: 250
                    from: 1
                    to: 0
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: date
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
                    target: nowbar
                    property: "opacity"
                    duration: 250
                    from: 1
                    to: 0
                    easing.type: Easing.OutQuad
                }
            }
            PauseAnimation {
                duration: 200
            }
            ScriptAction {
                script: {
                    LockContext.locked = false;
                }
            }
        }
    }

    Date {
        id: date
        size: lockRoot.fontSize * 2
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: clock.top
            bottomMargin: lockRoot.fontSize / 2
        }
    }

    CLock {
        id: clock
        size: lockRoot.screen?.height / 8
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: lockRoot.screen?.height / 4
        }
    }

    Text {
        id: username
        text: SessionInfo.user
        color: Colors.color10
        font.family: "Comfortaa"
        font.pixelSize: Math.floor(lockRoot.fontSize * 1.5) | 0
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: passwordArea.top
            bottomMargin: lockRoot.fontSize / 2
        }
    }

    ClippingRectangle {
        id: passwordArea
        implicitWidth: lockRoot.screen?.width / 4
        implicitHeight: lockRoot.screen?.height / 20
        radius: height / 3
        color: Colors.transground2
        border {
            color: {
                if (!passwordInput.focus || incorrect.visible) {
                    return "#212121";
                } else if (LockContext.unlockInProgress) {
                    return Colors.color14;
                } else {
                    return Colors.color3;
                }
            }
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
            bottomMargin: lockRoot.screen?.height / 4
        }
        TextInput {
            id: passwordInput
            anchors.fill: parent
            anchors.margins: 10
            enabled: !LockContext.unlockInProgress && !failAnim.running
            onAccepted: {
                LockContext.currentText = text;
                LockContext.tryUnlock();
            }
            focus: true
            color: "transparent"
            horizontalAlignment: Text.AlignHCenter
            cursorVisible: false
            selectionColor: "transparent"
            selectedTextColor: "transparent"
            Keys.onEscapePressed: {
                passwordInput.text = "";
            }
            cursorDelegate: Rectangle {
                visible: false
            }
            HoverHandler {
                cursorShape: Qt.IBeamCursor
            }
            onTextChanged: {
                if (text.length === 0) {
                    dotModel.clear();
                } else if (text.length > dotModel.count) {
                    dotModel.append({
                        "text": "●"
                    });
                } else if (text.length < dotModel.count) {
                    dotModel.remove(dotModel.count - 1);
                }
            }
        }
        ListModel {
            id: dotModel
        }
        ListView {
            id: dotList
            anchors.centerIn: parent
            height: parent.height
            orientation: ListView.Horizontal
            property real dotSize: lockRoot.fontSize
            width: count * (dotSize + 4)
            spacing: height * 0.12
            model: dotModel
            opacity: !incorrect.visible ? 1 : 0
            visible: opacity > 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuint
                }
            }
            Behavior on width {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuint
                }
            }
            delegate: Item {
                width: dotList.dotSize
                height: dotList.height
                Rectangle {
                    anchors.centerIn: parent
                    width: dotList.dotSize
                    height: width
                    radius: width / 2
                    color: Colors.foreground
                }
            }
            add: Transition {
                NumberAnimation {
                    property: "scale"
                    from: 0.0
                    to: 1.0
                    duration: 180
                    easing.type: Easing.OutBack
                    easing.amplitude: 1.3
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 130
                }
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "scale"
                        to: 0.0
                        duration: 150
                        easing.type: Easing.InQuint
                    }
                    NumberAnimation {
                        property: "opacity"
                        to: 0.0
                        duration: 150
                    }
                }
            }
            displaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 120
                    easing.type: Easing.OutExpo
                }
            }
        }
        Text {
            id: incorrect
            text: "Incorrect Password"
            anchors.centerIn: parent
            color: Colors.foreground
            opacity: 0
            visible: opacity > 0
            font.pixelSize: 20
            font.family: "Comfortaa"

            Connections {
                target: LockContext
                function onShowFailureChanged() {
                    if (LockContext.showFailure) {
                        failAnim.restart();
                    }
                }
            }
            SequentialAnimation {
                id: failAnim
                ScriptAction {
                    script: {
                        passwordInput.text = "";
                    }
                }
                NumberAnimation {
                    target: incorrect
                    property: "opacity"
                    duration: 250
                    to: 0.8
                    easing.type: Easing.InCirc
                }
                PauseAnimation {
                    duration: 500
                }
                NumberAnimation {
                    target: incorrect
                    property: "opacity"
                    duration: 250
                    to: 0
                    easing.type: Easing.OutCirc
                }
            }
        }
    }
    NowBar {
        id: nowbar
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: lockRoot.screen?.height / 10
        }
    }
}
