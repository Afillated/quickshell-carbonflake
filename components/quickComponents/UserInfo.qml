import Quickshell
import QtQuick

import qs.services
import qs.theme

Rectangle {
    id: userDetails
    color: Colors.transground2
    radius: height / 3
    property real fontSize
    Text {
        id: username
        text: SessionInfo.user
        color: Colors.color10
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }
        font {
            pixelSize: userDetails.fontSize * 1.2
            weight: 420
        }
    }
    Text {
        id: uptime
        text: "Uptime: " + SessionInfo.uptime
        color: Colors.color10
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 8
        }
        font {
            pixelSize: userDetails.fontSize * 1.1
            weight: 420
        }
    }
}
