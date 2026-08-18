import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

import qs.services
import qs.theme

Label {
    id: clock
    text: Time.time
    signal click
    property real fontSize
    property real radius
    property real recHeight
    color: area.containsMouse ? Colors.color12 : Colors.color15
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    font.pixelSize: fontSize
    font.family: "Noto Sans"
    font.weight: 400
    background: ClippingRectangle {
        id: background
        color: area.containsMouse ? "#33AAAAAA" : "transparent"
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        radius: height / 3
        implicitHeight: clock.recHeight
        MouseArea {
            id: area
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                clock.click();
            }
        }
    }
}
