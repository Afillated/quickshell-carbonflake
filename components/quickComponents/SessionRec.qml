import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.services

ClippingRectangle {
    id: sessionRec
    color: Colors.transground2
    border {
        width: 2
        color: Colors.color3
    }
    property real fontSize
    property int butRadius
    RowLayout {
        id: sessionLayout
        anchors.fill: parent
        anchors.margins: sessionRec.fontSize / 3
        Rectangle {
            id: lockButton
            radius: sessionRec.butRadius
            color: area.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
            MouseArea {
                id: area
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    LockContext.locked = true;
                }
            }
            border {
                color: area.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }

            Text {
                text: ""
                color: area.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: shutButton
            radius: sessionRec.butRadius
            color: area2.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
            MouseArea {
                id: area2
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Quickshell.execDetached(["systemctl", "poweroff"]);
                }
            }
            border {
                color: area2.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Text {
                text: "󰐥"
                color: area2.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: susButton
            radius: sessionRec.butRadius
            color: area5.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
            MouseArea {
                id: area5
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Quickshell.execDetached(["systemctl", "suspend"]);
                }
            }
            border {
                color: area5.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Text {
                text: "󰤄"
                color: area5.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: restartButton
            radius: sessionRec.butRadius
            color: area3.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
            MouseArea {
                id: area3
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Quickshell.execDetached(["systemctl", "reboot"]);
                }
            }
            border {
                color: area3.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }

            Text {
                text: "󰜉"
                color: area3.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: logButton
            radius: sessionRec.butRadius
            color: area4.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
            MouseArea {
                id: area4
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Quickshell.execDetached(["uwsm", "stop"]);
                }
            }
            border {
                color: area4.containsMouse ? Colors.color3 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Text {
                text: "󰍃"
                color: area4.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
