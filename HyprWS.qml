pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets

Rectangle {
    id: hyprWS
    color: "#960000"
    implicitHeight: 30
    implicitWidth: wsRow.width + 20
    radius: 15
    RowLayout {
        id: wsRow
        anchors.centerIn: parent

        spacing: 8
        Repeater {
            model: ScriptModel {
                id: wsModel
                values: Hyprland.workspaces.values.filter(workspace => workspace.id >= 0)
            }
            Button {
                id: wsButton
                required property HyprlandWorkspace modelData
                implicitHeight: hyprWS.height - 10
                implicitWidth: modelData?.focused ? 60 : 40
                background: Rectangle {
                    anchors.fill: parent
                    color: wsButton.modelData?.active ? "#400000" : "#AA2A0808"
                    radius: 15
                }
                action: Action {
                    onTriggered: wsButton.modelData.activate()
                }
                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: parent.click()
                }
            }
        }
    }
}
