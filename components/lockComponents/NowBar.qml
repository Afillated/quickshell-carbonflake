import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components.playerComponents
import qs.theme
import qs.services

ClippingRectangle {
    id: mediaRec
    color: "transparent"

    property int collapsedWidth: 250
    property int collapsedHeight: 60
    property int expandedWidth: 460
    property int expandedHeight: 200
    property int fontSize: 18
    implicitWidth: collapsedWidth
    implicitHeight: collapsedHeight
    opacity: MprisPlayers.activePlayer ? 1 : 0
    scale: MprisPlayers.activePlayer ? 1 : 0.8
    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }
    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }
    // state: "collapsed"
    ClippingRectangle {
        id: colapseRec
        anchors.fill: parent
        color: Colors.transground2
        radius: height / 3
        border {
            color: Colors.color3
            width: 2
        }
        RowLayout {
            anchors.fill: parent
            anchors.margins: 5
            ClippingRectangle {
                id: imageRec
                implicitHeight: parent.height
                implicitWidth: height
                radius: height / 3
                Image {
                    anchors.fill: parent
                    source: qsTr(MprisPlayers.activePlayer?.trackArtUrl || "")
                    fillMode: Image.PreserveAspectCrop
                }
            }
            ColumnLayout {
                spacing: mediaRec.fontSize / 2
                Layout.fillWidth: true
                Text {
                    text: MprisPlayers.activePlayer?.trackTitle || "No Title"
                    color: "#967373"
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    Layout.alignment: Qt.AlignHCenter
                    horizontalAlignment: Text.AlignHCenter
                    font {
                        family: "Comfortaa"
                        pixelSize: 15
                        weight: 700
                    }
                }
                PlayerControls {
                    id: songControl
                    fontSize: 15
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
