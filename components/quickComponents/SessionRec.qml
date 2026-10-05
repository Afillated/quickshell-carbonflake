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
            id: dndButton
            radius: sessionRec.butRadius
            color: area.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea {
                id: area
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    NotiServer.toggleDND();
                }
            }
            border {
                color: area.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            Rectangle {
                implicitHeight: parent.height * 0.76
                implicitWidth: parent.width * 0.76
                radius: parent.radius
                anchors.centerIn: parent
                color: NotiServer.doNotDisturb ? Colors.color13 : "#55967373"
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                Text {
                    text: {
                        if (NotiServer.doNotDisturb)
                            return " 󰍷 ";
                        else
                            return " 󱑚 ";
                    }
                    color: NotiServer.doNotDisturb ? Colors.background : Colors.color15
                    anchors.centerIn: parent
                    font.pixelSize: sessionRec.fontSize
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: protectButton
            radius: sessionRec.butRadius
            color: area2.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea {
                id: area2
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    BatteryProtection.toggleMode();
                }
            }
            border {
                color: area2.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            Rectangle {
                implicitHeight: parent.height * 0.76
                implicitWidth: parent.width * 0.76
                radius: parent.radius
                anchors.centerIn: parent
                color: BatteryProtection.conservationEnabled ? Colors.color13 : "#55967373"
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                Text {
                    text: {
                        if (BatteryProtection.conservationEnabled)
                            return "󱞜";
                        else
                            return "󱞝";
                    }
                    color: BatteryProtection.conservationEnabled ? Colors.background : Colors.color15
                    anchors.centerIn: parent
                    font.pixelSize: sessionRec.fontSize
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: lockButton
            radius: sessionRec.butRadius
            color: area3.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea {
                id: area3
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    LockContext.locked = true;
                }
            }
            border {
                color: area3.containsMouse ? Colors.color4 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }

            Text {
                text: ""
                color: area3.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Rectangle {
            id: menuButton
            radius: sessionRec.butRadius
            color: area4.containsMouse ? "#CC111111" : "#55000000"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea {
                id: area4
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    Quickshell.execDetached(["qs", "ipc", "call", "sessionPanel", "open"]);
                }
            }
            border {
                color: area4.containsMouse ? Colors.color3 : "#212121"
                width: 2
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            Text {
                text: ""
                color: area4.containsMouse ? Colors.color14 : Colors.foreground
                anchors.centerIn: parent
                font.pixelSize: sessionRec.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
