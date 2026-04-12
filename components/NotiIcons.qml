pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.services
import QtQuick.Layouts

Rectangle {
    id: notiIcon
    color: "transparent"

    property int iconSize: 26

    implicitWidth: 30
    implicitHeight: 30

    required property var noti

    property string iconPath: noti?.appIcon ? Quickshell.iconPath(noti.appIcon, true) : ""

    Image {
        id: appIconImage
        anchors.centerIn: parent
        source: notiIcon.iconPath
        sourceSize {
            width: notiIcon.iconSize
            height: notiIcon.iconSize
        }
        visible: notiIcon.iconPath !== ""
    }

    Text {
        id: placeholder
        anchors.centerIn: parent
        text: ""
        font.pixelSize: 26
        color: "#967373"
        visible: notiIcon.iconPath === ""

        font.family: "Comfortaa"
    }
}
