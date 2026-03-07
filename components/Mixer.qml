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
    required property PwNode node

    PwNodeLinkTracker {
        id: link
        node: mixerRec.node
    }
    Label {
        id: title
        text: "Playback"
        color: "#967373"
        font {
            family: "Comfortaa"
            weight: 500
            pixelSize: 40
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 30
        }
    }
    ClippingRectangle {
            anchors {
                bottom: closeButton.top
                right: parent.right
                left: parent.left
                top: title.bottom
                margins: 10
                topMargin: 30
            }
            color: "transparent"
            radius: 20
            border {
                width: 2
                color: "#CC960000"
            }
        ListView {
            id: list
            model: link.linkGroups
            anchors.fill: parent
            anchors.margins: 10
            delegate: MixerEntry {
                required property PwLinkGroup modelData
                node: modelData.source
                width: list.width
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
