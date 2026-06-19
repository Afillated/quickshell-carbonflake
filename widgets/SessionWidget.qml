import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.components
import qs.theme

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: sessionPanel
            required property var modelData
            screen: modelData
            visible: false
            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }
            exclusionMode: ExclusionMode.Ignore
            color: Colors.transground
            property real fontSize: screen?.height * 0.02
            IpcHandler {
                target: "sessionPanel"
                function open(): void {
                    sessionPanel.visible = true;
                }
                function close(): void {
                    sessionPanel.visible = false;
                }
            }
            focusable: true
            Shortcut {
                sequence: "Escape"
                onActivated: {
                    sessionPanel.visible = false;
                    layout.lfocus = true;
                }
            }
            ClippingRectangle {
                id: sessionRec
                implicitHeight: sessionPanel.screen?.height * 0.26
                implicitWidth: sessionPanel.screen?.width * 0.6
                anchors.centerIn: parent
                radius: 10
                border {
                    width: 2
                    color: Colors.color3
                }
                color: Colors.transground3
                SessionLayout {
                    id: layout
                    butRadius: 10
                    fontSize: sessionPanel.fontSize * 3
                    visible: sessionPanel.visible
                    onClose: {
                        sessionPanel.visible = false;
                    }
                    anchors {
                        top: parent.top
                        bottom: userDetails.top
                        right: parent.right
                        left: parent.left
                        margins: 10
                        bottomMargin: anchors.margins / 4
                    }
                }
                Rectangle {
                    id: userDetails
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        left: parent.left
                    }
                    implicitHeight: parent.height / 8
                    color: "transparent"
                    Text {
                        id: username
                        text: SessionInfo.user
                        color: "#967373"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: 10
                        }
                        font {
                            family: "Comfortaa"
                            pixelSize: sessionPanel.fontSize
                            weight: 420
                        }
                    }
                    Text {
                        id: uptime
                        text: "Uptime: " + SessionInfo.uptime
                        color: "#967373"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                            rightMargin: 8
                        }
                        font {
                            family: "Comfortaa"
                            pixelSize: sessionPanel.fontSize
                            weight: 420
                        }
                    }
                }
            }
        }
    }
}
