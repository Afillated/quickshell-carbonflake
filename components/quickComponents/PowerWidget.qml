import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.theme
import qs.services
import qs.components

ClippingRectangle {
    id: powerRec
    color: Colors.transground2
    border {
        width: 2
        color: Colors.color3
    }
    property real fontSize
    property int butRadius
    RowLayout {
        id: mainRow
        anchors.fill: parent
        anchors.margins: 10
        spacing: powerRec.fontSize / 2
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: powerRec.fontSize / 2
            Layout.maximumWidth: powerRec.width * 0.4
            RowLayout {
                Text {
                    id: percentage
                    text: Math.floor(Battery.percentage * 100) + "%"
                    color: Colors.foreground
                    font.pixelSize: powerRec.fontSize
                    font.weight: 600
                }
                Seperator {
                    implicitHeight: powerRec.fontSize
                }
                Text {
                    id: title
                    text: {
                        if (Battery.isCharging) {
                            return "Charging";
                        } else if (Battery.isFullyCharged && Battery.estimatedTime == 0) {
                            return "Plugged In";
                        } else {
                            return "Draining";
                        }
                    }
                    color: Colors.foreground
                    font.pixelSize: powerRec.fontSize
                    font.weight: 600
                    elide: Text.ElideRight
                }
            }
            Text {
                id: status
                text: Battery.formatETA(Battery.estimatedTime)
                color: Colors.foreground
                font.pixelSize: powerRec.fontSize
            }

            Text {
                id: profile
                text: Battery.profileName
                color: Colors.foreground
                font.pixelSize: powerRec.fontSize
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: powerRec.fontSize / 2
            Behavior on width {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
            Rectangle {
                id: perfButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Battery.activeProfile == PowerProfile.Performance || perfArea.containsMouse ? "#11CCCCCC" : "transparent"
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                radius: powerRec.butRadius
                border {
                    color: Battery.activeProfile == PowerProfile.Performance ? Colors.color4 : "#212121"
                    width: 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                Text {
                    anchors.centerIn: parent
                    text: "󰓅"
                    color: Battery.activeProfile == PowerProfile.Performance || perfArea.containsMouse ? Colors.color14 : Colors.color15
                    font.pixelSize: powerRec.fontSize * 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                MouseArea {
                    id: perfArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Battery.setProfile(PowerProfile.Performance)
                }
            }
            Rectangle {
                id: balButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Battery.activeProfile == PowerProfile.Balanced || balArea.containsMouse ? "#11CCCCCC" : "transparent"
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                radius: powerRec.butRadius
                border {
                    color: Battery.activeProfile == PowerProfile.Balanced ? Colors.color4 : "#212121"
                    width: 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                Text {
                    anchors.centerIn: parent
                    text: "󰘮"
                    color: Battery.activeProfile == PowerProfile.Balanced || balArea.containsMouse ? Colors.color14 : Colors.color15
                    font.pixelSize: powerRec.fontSize * 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                MouseArea {
                    id: balArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Battery.setProfile(PowerProfile.Balanced)
                }
            }
            Rectangle {
                id: savButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Battery.activeProfile == PowerProfile.PowerSaver || savArea.containsMouse ? "#11CCCCCC" : "transparent"
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                radius: powerRec.butRadius
                border {
                    color: Battery.activeProfile == PowerProfile.PowerSaver ? Colors.color4 : "#212121"
                    width: 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                Text {
                    anchors.centerIn: parent
                    text: "󰌪"
                    color: Battery.activeProfile == PowerProfile.PowerSaver || savArea.containsMouse ? Colors.color14 : Colors.color15
                    font.pixelSize: powerRec.fontSize * 2
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                MouseArea {
                    id: savArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Battery.setProfile(PowerProfile.PowerSaver)
                }
            }
        }
    }
}
