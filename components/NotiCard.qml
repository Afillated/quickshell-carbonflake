pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import qs.services
import QtQuick.Layouts

Rectangle {
    id: notiCard

    required property var noti

    color: "transparent"

    border {
        width: 1.5
        color: "#CC960000"
    }

    implicitHeight: cardContent.height + 20
    implicitWidth: 400
    radius: 10

    MouseArea {
        id: closeMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (notiCard.noti && notiCard.noti.noti && notiCard.noti.noti.dismiss) {
                notiCard.noti.noti.dismiss();
            }

            NotiServer.items.remove(index);
        }
    }
    ColumnLayout {
        id: cardContent
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            margins: 10
        }
        spacing: 4

        RowLayout {
            id: appDetails
            implicitHeight: 40
            spacing: 0
            Loader {
                id: appIcons
                Layout.rightMargin: 10
                active: notiCard.noti && notiCard.noti?.appIcon
                sourceComponent: IconImage {
                    source: Quickshell.iconPath(notiCard.noti.appIcon)
                    implicitSize: 30
                }
            }

            Text {
                id: appNames
                text: notiCard.noti?.appName
                color: "#967373"
                font {
                    family: "Firacode Mono Nerd Font"
                    pixelSize: 20
                }
            }
        }
        RowLayout {
            id: actualNoti
            Layout.fillWidth: cardContent
            spacing: 10
            Loader {
                id: image
                Layout.leftMargin: 10
                active: notiCard.noti && notiCard.noti?.image
                sourceComponent: IconImage {
                    source: notiCard.noti.image
                    implicitSize: 60
                }
            }

            ColumnLayout {
                id: notiContent
                spacing: 0
                Layout.margins: 10
                Text {
                    id: summary
                    text: notiCard.noti?.summary
                    color: "#967373"
                    font.weight: Font.Bold
                    font.family: "Firacode Mono Nerd Font"
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
                Text {
                    id: body
                    text: notiCard.noti?.body
                    color: "#967373"
                    font.family: "Firacode Mono Nerd Font"
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
            }
        }
    }
}
