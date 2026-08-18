pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.theme

RowLayout {
    id: hyprWS
    spacing: butSize / 2
    Layout.alignment: Qt.AlignVCenter
    property int butSize
    property int fontSize
    Repeater {
        model: ScriptModel {
            values: Hyprland.workspaces.values.filter(workspace => workspace.id >= 0).sort((a, b) => a.id - b.id)
        }
        Rectangle {
            id: wsButton
            required property HyprlandWorkspace modelData
            color: modelData?.focused || wsArea.containsMouse ? Colors.color9 : "#33AAAAAA"
            implicitWidth: modelData?.active ? height * 1.8 : height * 1.4
            implicitHeight: hyprWS.butSize
            radius: height / 3
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
            MouseArea {
                id: wsArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                enabled: !wsButton.modelData?.focused
                onClicked: wsButton.modelData?.activate()
            }
            Text {
                id: name
                text: wsButton.modelData?.id
                color: wsButton.modelData?.active || wsArea.containsMouse ? Colors.color15 : Colors.color10
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Firacode NerdFont"
                font.weight: 400
                font.pixelSize: hyprWS.fontSize
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }
            }
        }
    }
}
