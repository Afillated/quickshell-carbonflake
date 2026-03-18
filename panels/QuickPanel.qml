import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.services
import qs.components
import Quickshell.Io

PopupWindow {
    id: quickPanel
    implicitHeight: 800
    implicitWidth: 500

    color: "transparent"
    property bool isOpen: false
    onIsOpenChanged: {
        if (isOpen === true) {
            visible = true;
        } else {
            visible = false;
        }
    }
    HyprlandFocusGrab {
        id: grab
        active: quickPanel.isOpen
        windows: [quickPanel]
        onCleared: {
            closeAnim.start();
        }
    }

    anchor {
        edges: Edges.Right | Edges.Bottom
        gravity: Edges.Top | Edges.Left
    }

    SequentialAnimation {
        id: closeAnim
        ParallelAnimation {
            NumberAnimation {
                target: quickRec
                property: "implicitHeight"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: fullName
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: sessionBar
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: volumeRockers
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: mixerSink
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: mixerSource
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: sessionBar
                property: "opacity"
                to: 0
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
        ScriptAction {
            script: {
                quickPanel.visible = false;
                quickPanel.isOpen = false;
                mixerSource.state = "";
                mixerSink.state = "";
            }
        }
    }

    Rectangle {
        id: quickRec
        anchors.bottom: parent.bottom
        color: "#E6000000"
        radius: 15
        border {
            width: 1.5
            color: "#CC960000"
        }

        implicitHeight: quickPanel.visible ? parent.height : 0
        implicitWidth: parent.width

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
        Mixer {
            id: mixerSource
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.right
                right: undefined
                margins: 10
            }
            node: Audio.defaultOutput
            title: "Playback"
            width: parent.width - 20
            opacity: state === "open" || quickPanel.visible ? 1 : 0
            visible: opacity > 0
            z: 1
            MouseArea {
                anchors.fill: parent
                z: -1
            }

            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
            onClose: {
                state = "";
            }
            onChange: {
                state = "";
                mixerSink.state = "open";
            }
            states: State {
                name: "open"
                AnchorChanges {
                    target: mixerSource
                    anchors.right: parent.right
                    anchors.left: parent.left
                }
            }
            transitions: Transition {
                AnchorAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
        }
        Mixer {
            id: mixerSink
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.right
                right: undefined
                margins: 10
            }
            node: Audio.defaultInput
            title: "Recording"
            width: parent.width - 20
            opacity: state === "open" || quickPanel.visible ? 1 : 0
            visible: opacity > 0
            z: 1
            MouseArea {
                anchors.fill: parent
                z: -1
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
            onClose: {
                state = "";
            }
            onChange: {
                state = "";
                mixerSource.state = "open";
            }
            states: State {
                name: "open"
                AnchorChanges {
                    target: mixerSink
                    anchors.right: parent.right
                    anchors.left: parent.left
                }
            }
            transitions: Transition {
                AnchorAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
        }

        VolumeMenu {
            id: volumeRockers
            opacity: quickPanel.visible ? 1 : 0
            radius: 20
            implicitHeight: 120
            anchors {
                right: parent.right
                left: parent.left
                bottom: fullName.top
                margins: 10
            }
            onOpen: {
                mixerSource.state = "open";
            }
            onOpen2: {
                mixerSink.state = "open";
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }
        Rectangle {
            id: sessionBar
            implicitHeight: 130
            color: "transparent"
            radius: 20
            opacity: quickPanel.visible ? 1 : 0
            border {
                color: "#CC960000"
                width: 1.5
            }
            anchors {
                bottom: volumeRockers.top
                left: parent.left
                right: parent.right
                margins: 10
            }
            SessionLayout {
                anchors.fill: parent
                anchors.margins: 10
                fontSize: 28
                butRadius: 16
                Keys.onEscapePressed: {
                    closeAnim.start();
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }

        Text {
            id: fullName
            text: Username.user
            color: "#967373"
            opacity: quickPanel.visible ? 1 : 0
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                left: parent.left
                leftMargin: 16
            }
            font {
                family: "Comfortaa"
                pixelSize: 20
            }
            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    duration: 250
                }
            }
        }
    }
}
