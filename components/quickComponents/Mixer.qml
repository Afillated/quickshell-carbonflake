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
    signal change
    property int fontSize
    property string title
    property string butRadius
    property var nodeList

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 10
        Label {
            id: title
            text: mixerRec.title
            color: Colors.color15
            font.pixelSize: mixerRec.fontSize * 3
            font.family: "Comfortaa"
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: mixerRec.fontSize
            Layout.bottomMargin: mixerRec.fontSize
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
                model: mixerRec.nodeList
                anchors.fill: parent
                anchors.margins: 10
                spacing: mixerRec.fontSize / 2
                delegate: MixerEntry {
                    id: element
                    required property PwNode modelData
                    node: modelData
                    implicitWidth: parseFloat(parent?.width)
                    fontSize: mixerRec.fontSize
                }
                add: Transition {
                    ParallelAnimation {
                        NumberAnimation {
                            property: "height"
                            from: 0
                            duration: 250
                            easing.type: Easing.OutBack
                        }
                        NumberAnimation {
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                        NumberAnimation {
                            property: "scale"
                            from: 0.8
                            to: 1
                            duration: 250
                            easing.type: Easing.OutBack
                        }
                    }
                }

                remove: Transition {
                    ParallelAnimation {
                        NumberAnimation {
                            property: "height"
                            to: 0
                            duration: 200
                            easing.type: Easing.InCubic
                        }
                        NumberAnimation {
                            property: "opacity"
                            to: 0
                            duration: 150
                            easing.type: Easing.InCubic
                        }
                        NumberAnimation {
                            property: "scale"
                            to: 0.8
                            duration: 200
                            easing.type: Easing.InCubic
                        }
                    }
                }

                displaced: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }
            Text {
                anchors.centerIn: parent
                text: "No applications"
                opacity: mixerRec.nodeList.count === 0 ? 1 : 0
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
            implicitHeight: text.height * 1.5
            Layout.fillWidth: true
            color: "transparent"
            Layout.topMargin: layout.anchors.margins / 2
            Rectangle {
                id: prevButton
                color: prev.containsMouse ? "#CC111111" : "transparent"
                radius: height / 3
                implicitHeight: text.height * 1.5
                implicitWidth: height
                border {
                    color: "#222222"
                    width: 2
                }
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: closeButton.left
                    rightMargin: mixerRec.fontSize / 2
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                MouseArea {
                    id: prev
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: mixerRec.change()
                }
                Text {
                    text: ""
                    color: prev.containsMouse ? Colors.color10 : Colors.foreground
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
            Rectangle {
                id: closeButton
                color: close.containsMouse ? "#CC111111" : "transparent"
                radius: height / 3
                implicitHeight: text.height * 1.5
                implicitWidth: layout.width / 1.5
                anchors.centerIn: parent
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
}
