pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services

ClippingRectangle {
    id: mixerRec
    radius: 10
    color: "#010101"
    signal close
    signal change
    required property PwNode node
    property string title

    PwNodeLinkTracker {
        id: link
        node: mixerRec.node
    }
    Label {
        id: titleL
        text: mixerRec.title
        color: labelA.containsMouse ? "#960000" : "#967373"
        padding: 10
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
        font {
            family: "Comfortaa"
            weight: 500
            pixelSize: 40
        }
        background: ClippingRectangle {
            radius: 20
            color: labelA.containsMouse ? "#CC111111" : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 30
        }
        MouseArea {
            id: labelA
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: mixerRec.change()
        }
    }
    ClippingRectangle {
        anchors {
            bottom: closeButton.top
            right: parent.right
            left: parent.left
            top: titleL.bottom
            margins: 10
            topMargin: 30
        }
        color: "transparent"
        radius: 20
        border {
            width: 2
            color: "#CC960000"
        }
        MixerEntry {
            id: source
            node: mixerRec.node
            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
                margins: 10
            }
        }

        ClippingRectangle {
            anchors {
                bottom: parent.bottom
                top: source.bottom
                right: parent.right
                left: parent.left
            }
            color: "transparent"
            radius: 20
            ListView {
                id: list
                model: link.linkGroups
                anchors.fill: parent
                anchors.margins: 10
                anchors.topMargin: 0
                delegate: MixerEntry {
                    id: element
                    required property PwLinkGroup modelData
                    node: modelData.source === mixerRec.node ? modelData?.target : modelData?.source
                    width: list.width
                }
            }
        }
    }
    Rectangle {
        id: closeButton
        color: close.containsMouse ? "#CC111111" : "transparent"
        radius: 20
        implicitHeight: 40
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 20
        }
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
            text: "Close"
            color: close.containsMouse ? "#960000" : "#967373"
            anchors.centerIn: parent
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            font {
                family: "Comfortaa"
                weight: 500
                pixelSize: 20
            }
        }
    }
}
