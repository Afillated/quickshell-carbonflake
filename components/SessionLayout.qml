import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell.Io
import qs.services

RowLayout {
    id: sessionLayout
    property real fontSize
    property real butRadius
    spacing: 8
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
            }
        }
        focus: true
        border {
            color: focus ? "#CC960000" : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        Text {
            text: ""
            color: area.containsMouse || lockButton.focus ? "#960000" : "#967373"
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize - 2
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
            onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
        }
        border {
            color: focus ? "#CC960000" : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Text {
            text: "󰐥"
            color: area2.containsMouse || shutButton.focus ? "#960000" : "#967373"
            anchors.centerIn: parent
            font.pixelSize: sessionLayout.fontSize
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Keys.onReturnPressed: Quickshell.execDetached(["systemctl", "poweroff"])

        Layout.fillHeight: true
        Layout.fillWidth: true
        KeyNavigation.right: restartButton
        KeyNavigation.left: lockButton
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
            onClicked: Quickshell.execDetached(["systemctl", "reboot"])
        }
        border {
            color: focus ? "#CC960000" : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        Text {
            text: "󰜉"
            color: area3.containsMouse || restartButton.focus ? "#960000" : "#967373"
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
        KeyNavigation.left: shutButton
        Keys.onReturnPressed: Quickshell.execDetached(["systemctl", "reboot"])
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
            onClicked: Quickshell.execDetached(["uwsm", "stop"])
        }
        border {
            color: focus ? "#CC960000" : "#111111"
            width: 2
            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }
        Text {
            text: "󰍃"
            color: area4.containsMouse || logButton.focus ? "#960000" : "#967373"
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
        Keys.onReturnPressed: Quickshell.execDetached(["uwsm", "stop"])
    }
}
