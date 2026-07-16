pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.theme
import qs.components.quickComponents

ClippingRectangle {
    id: mixerRec
    color: Colors.background
    signal close
    property int fontSize
    property string title
    property string butRadius
    required property PwNode node
    property var nodeList

    PwNodeLinkTracker {
        id: link
        node: mixerRec.node
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 10
        Label {
            id: title
            text: mixerRec.title
            color: Colors.color14
            font.pixelSize: mixerRec.fontSize * 3
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: mixerRec.fontSize
            Layout.bottomMargin: mixerRec.fontSize
        }
        MixerEntry {
            node: mixerRec.node
            fontSize: mixerRec.fontSize
            Layout.fillWidth: true
            Layout.bottomMargin: layout.anchors.margins / 2
        }
        ClippingRectangle {
            id: listRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: mixerRec.butRadius
            color: "transparent"
            border {
                color: Colors.color3
                width: 2
            }
            ListView {
                id: list
                model: link.linkGroups
                anchors.fill: parent
                anchors.margins: 10
                spacing: mixerRec.fontSize / 2
                delegate: MixerEntry {
                    id: element
                    required property PwLinkGroup modelData
                    node: modelData?.source === mixerRec.node ? modelData?.target : modelData?.source
                    implicitWidth: parent.width
                    fontSize: mixerRec.fontSize
                }
            }
            Text {
                anchors.centerIn: parent
                text: "No applications"
                opacity: link.linkGroups.length === 0 ? 1 : 0
                visible: opacity > 0
                color: Colors.color10
                font.pixelSize: mixerRec.fontSize * 1.4
                font.weight: 500
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InCirc
                    }
                }
            }
        }
        Rectangle {
            id: closeButton
            color: close.containsMouse ? "#CC111111" : "transparent"
            radius: height / 3
            implicitHeight: text.height * 1.5
            implicitWidth: parent.width / 1.5
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: layout.anchors.margins / 2
            border {
                color: "#222222"
                width: 2
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea {
                id: close
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                anchors.fill: parent
                onClicked: mixerRec.close()
            }
            Text {
                id: text
                text: "Close"
                color: close.containsMouse ? Colors.color10 : Colors.foreground
                anchors.centerIn: parent
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                font {
                    weight: 500
                    pixelSize: mixerRec.fontSize * 1.5
                }
            }
        }
    }
}
