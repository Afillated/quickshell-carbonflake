pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.services

ListView {
    id: notiList
    property real fontSize
    spacing: fontSize / 2
    model: NotiServer.items
    orientation: ListView.Vertical
    delegate: NotiCard {
        required property var modelData
        required property int index
        width: notiList.width
        noti: modelData
        fontSize: notiList.fontSize
        onClicked: {
            NotiServer.items.remove(index);
        }
    }
    add: Transition {
        ParallelAnimation {
            NumberAnimation {
                property: "height"
                from: 0
                duration: 250
                easing.type: Easing.OutBack
            }
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "scale"
                from: 0.8
                to: 1
                duration: 250
                easing.type: Easing.OutBack
            }
        }
    }

    remove: Transition {
        ParallelAnimation {
            NumberAnimation {
                property: "height"
                to: 0
                duration: 200
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                property: "opacity"
                to: 0
                duration: 150
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                property: "scale"
                to: 0.8
                duration: 200
                easing.type: Easing.InCubic
            }
        }
    }

    displaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
    ColumnLayout {
        id: noNoti
        anchors.centerIn: parent
        opacity: NotiServer.items.count === 0 ? 1 : 0
        visible: opacity > 0
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "No notifications"
            color: Colors.color10
            font {
                pixelSize: notiList.fontSize
            }
        }
        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.OutQuad
                duration: 250
            }
        }
    }
}
