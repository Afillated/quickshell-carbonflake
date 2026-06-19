import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.theme
import qs.services

RowLayout {
    id: sessionLayout
    property int fontSize
    property int butRadius
    property alias lfocus: lockButton.focus
    signal close
    Rectangle {
        id: lockButton
        radius: sessionLayout.butRadius
        color: focus || area.containsMouse ? "#CC111111" : "#55000000"
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
                sessionLayout.close();
            }
        }
        focus: true
        border {
            color: focus ? Colors.color4 : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        Text {
            text: ""
            color: area.containsMouse || lockButton.focus ? Colors.color14 : Colors.foreground
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Layout.fillHeight: true
        Layout.fillWidth: true
        KeyNavigation.right: shutButton
        KeyNavigation.left: logButton
        Keys.onReturnPressed: {
            LockContext.locked = true;
            sessionLayout.close();
        }
    }
    Rectangle {
        id: shutButton
        radius: sessionLayout.butRadius
        color: focus || area2.containsMouse ? "#CC111111" : "#55000000"
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
                sessionLayout.close();
            }
        }
        border {
            color: focus ? Colors.color4 : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Text {
            text: "󰐥"
            color: area2.containsMouse || shutButton.focus ? Colors.color14 : Colors.foreground
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Keys.onReturnPressed: {
            Quickshell.execDetached(["systemctl", "poweroff"]);
            sessionLayout.close();
        }

        Layout.fillHeight: true
        Layout.fillWidth: true
        KeyNavigation.right: susButton
        KeyNavigation.left: lockButton
    }
    Rectangle {
        id: susButton
        radius: sessionLayout.butRadius
        color: focus || area5.containsMouse ? "#CC111111" : "#55000000"
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
                sessionLayout.close();
            }
        }
        border {
            color: focus ? Colors.color4 : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Text {
            text: "󰤄"
            color: area5.containsMouse || susButton.focus ? Colors.color14 : Colors.foreground
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Keys.onReturnPressed: {
            Quickshell.execDetached(["systemctl", "suspend"]);
            sessionLayout.close();
        }

        Layout.fillHeight: true
        Layout.fillWidth: true
        KeyNavigation.right: restartButton
        KeyNavigation.left: shutButton
    }
    Rectangle {
        id: restartButton
        radius: sessionLayout.butRadius
        color: focus || area3.containsMouse ? "#CC111111" : "#55000000"
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
                sessionLayout.close();
            }
        }
        border {
            color: focus ? Colors.color4 : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        Text {
            text: "󰜉"
            color: area3.containsMouse || restartButton.focus ? Colors.color14 : Colors.foreground
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Layout.fillHeight: true
        Layout.fillWidth: true
        KeyNavigation.right: logButton
        KeyNavigation.left: susButton
        Keys.onReturnPressed: {
            Quickshell.execDetached(["systemctl", "reboot"]);
            sessionLayout.close();
        }
    }
    Rectangle {
        id: logButton
        radius: sessionLayout.butRadius
        color: focus || area4.containsMouse ? "#CC111111" : "#55000000"
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
                sessionLayout.close();
            }
        }
        border {
            color: focus ? Colors.color3 : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Text {
            text: "󰍃"
            color: area4.containsMouse || logButton.focus ? Colors.color14 : Colors.foreground
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Layout.fillHeight: true
        Layout.fillWidth: true
        KeyNavigation.left: restartButton
        Keys.onReturnPressed: {
            Quickshell.execDetached(["uwsm", "stop"]);
            sessionLayout.close();
        }
    }
}
