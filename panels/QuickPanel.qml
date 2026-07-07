import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.theme
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
                    margins: 10
                    bottomMargin: anchors.margins / 2
                }
                BrightnessSlider {
                    implicitHeight: quickRec.height / 8
                    implicitWidth: parent.width
                    radius: quickRec.radius
                    fontSize: quickPanel.fontSize
                }
                PowerWidget {
                    id: powerRec
                    implicitWidth: parent.width
                    implicitHeight: quickRec.height / 6
                    radius: quickRec.radius
                    fontSize: quickPanel.fontSize
                    butRadius: radius / 2
                }
            }
        }
    }
}
