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

    property int collapsedWidth
    property int collapsedHeight
    property int expandedWidth
    property int expandedHeight
    property int fontSize
    implicitWidth: collapsedWidth
    implicitHeight: collapsedHeight
    opacity: MprisPlayers.activePlayer ? 1 : 0
    visible: MprisPlayers.playerList.length > 0
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
    property bool collapsed: state === "collapsed"
    state: "collapsed"
    ClippingRectangle {
        id: collapsedRec
        anchors.fill: parent
        color: Colors.transground2
        radius: height / 3
        visible: opacity > 0
        border {
            color: Colors.color3
            width: 2
        }
        RowLayout {
            anchors.fill: parent
            anchors.margins: parent.height * 0.1
            ClippingRectangle {
                id: imageRec
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: height
                radius: height / 3
                color: Colors.transground3
                Image {
                    anchors.fill: parent
                    source: qsTr(MprisPlayers.activePlayer?.trackArtUrl || "")
                    fillMode: Image.PreserveAspectCrop
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    enabled: mediaRec.state == "collapsed"
                    onClicked: mediaRec.state = "expanded"
                }
            }
            ColumnLayout {
                spacing: mediaRec.fontSize / 2
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignVCenter
                Text {
                    text: MprisPlayers.activePlayer?.trackTitle || "No Title"
                    color: Colors.color10
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    Layout.alignment: Qt.AlignHCenter
                    horizontalAlignment: Text.AlignHCenter
                    font {
                        family: "Comfortaa"
                        pixelSize: mediaRec.fontSize
                    }
                }
                PlayerControls {
                    id: songControl
                    fontSize: mediaRec.fontSize
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }

    Player {
        id: expandedRec
        anchors.fill: parent
        opacity: 0
        visible: opacity > 0
        onImageClick: {
            mediaRec.state = "collapsed";
        }
        fontSize: mediaRec.fontSize
        radius: height / 10
    }
    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                mediaRec.implicitWidth: mediaRec.collapsedWidth
                mediaRec.implicitHeight: mediaRec.collapsedHeight
                collapsedRec.opacity: 1
                expandedRec.opacity: 0
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                mediaRec.implicitWidth: mediaRec.expandedWidth
                mediaRec.implicitHeight: mediaRec.expandedHeight
                collapsedRec.opacity: 0
                expandedRec.opacity: 1
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            ParallelAnimation {
                NumberAnimation {
                    properties: "implicitWidth,implicitHeight,opacity"
                    duration: 300
                    easing.type: Easing.OutQuad
                }
                ColorAnimation {
                    duration: 300
                }
            }
        }
    ]
}
