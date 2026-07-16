import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.services
import qs.components.quickComponents

PopupWindow {
    id: quickPanel
    color: "transparent"
    property bool isOpen: false
    property real fontSize
    onIsOpenChanged: {
        if (isOpen === true) {
            visible = true;
        } else {
            visible = false;
        }
    }
    anchor {
        edges: Edges.Right | Edges.Bottom
        gravity: Edges.Top | Edges.Left
    }
    HyprlandFocusGrab {
        active: quickPanel.isOpen
        windows: [quickPanel]
        onCleared: {
            closeAnim.start();
        }
    }
    SequentialAnimation {
        id: closeAnim
        NumberAnimation {
            target: quickRec
            property: "y"
            to: quickRec.height
            duration: 200
            easing.type: Easing.OutQuad
        }
        ScriptAction {
            script: {
                quickPanel.isOpen = false;
                mixerSink.state = "";
                mixerSource.state = "";
            }
        }
    }
    ClippingRectangle {
        id: radRec
        color: "transparent"
        radius: quickRec.radius
        anchors.fill: parent
        ClippingRectangle {
            id: quickRec
            anchors.horizontalCenter: parent.horizontalCenter
            implicitHeight: parent.height
            implicitWidth: parent.width
            radius: 10
            color: Colors.transground4
            border {
                width: 2
                color: Colors.color3
            }
            y: quickPanel.isOpen ? 0 : height
            Behavior on y {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutQuad
                }
            }
            UserInfo {
                id: infoRec
                fontSize: quickPanel.fontSize
                implicitHeight: fontSize * 2
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
            }
            ColumnLayout {
                id: panelLayout
                Layout.maximumHeight: quickRec.height - (infoRec.height + anchors.margins)
                spacing: quickPanel.fontSize / 2
                anchors {
                    bottom: infoRec.top
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 10
                    bottomMargin: anchors.margins / 4
                }
                ClippingRectangle {
                    id: placeholder
                    color: Colors.transground2
                    border {
                        width: 2
                        color: Colors.color3
                    }
                    opacity: 0
                    radius: quickRec.radius
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
                PowerWidget {
                    id: powerRec
                    implicitWidth: parent.width
                    implicitHeight: quickRec.height / 6
                    radius: quickRec.radius
                    fontSize: quickPanel.fontSize
                    butRadius: radius / 2
                }
                SessionRec {
                    id: sessionRec
                    implicitWidth: parent.width
                    implicitHeight: quickRec.height / 6
                    radius: quickRec.radius
                    fontSize: quickPanel.fontSize * 2
                    butRadius: radius / 2
                }
                BrightnessSlider {
                    id: displayRec
                    implicitHeight: quickRec.height / 8
                    implicitWidth: parent.width
                    radius: quickRec.radius
                    fontSize: quickPanel.fontSize
                }
                AudioRec {
                    id: audioRec
                    implicitHeight: quickRec.height / 4
                    implicitWidth: parent.width
                    radius: quickRec.radius
                    fontSize: quickPanel.fontSize
                    onVolOpen: {
                        mixerSource.state = "open";
                    }
                    onMicOpen: {
                        mixerSink.state = "open";
                    }
                }
            }
            Mixer {
                id: mixerSource
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.right
                    right: undefined
                }
                implicitWidth: parent.width
                fontSize: quickPanel.fontSize
                butRadius: quickRec.radius
                title: "Playback"
                node: Audio.defaultOutput
                nodeList: Audio.outputList
                MouseArea {
                    anchors.fill: parent
                    z: -1
                }
                onClose: {
                    state = "";
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
                }
                implicitWidth: parent.width
                fontSize: quickPanel.fontSize
                butRadius: quickRec.radius
                title: "Recording"
                node: Audio.defaultInput
                MouseArea {
                    anchors.fill: parent
                    z: -1
                }
                onClose: {
                    state = "";
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
        }
    }
}
