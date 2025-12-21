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

    color: "#212121"

    border {
        width: 1.5
        color: "#960000"
    }

    ColumnLayout {
        id: cardContent
        anchors {
            fill: parent
            margins: 10
        }
        spacing: 10

        RowLayout {
            id: appDetails
            implicitHeight: 40
            spacing: 10

            Loader {
                id: appIcons
                Layout.rightMargin: 10
                active: notiCard.noti && notiCard.noti?.appIcon
                sourceComponent: IconImage {
                    source: Quickshell.iconPath(notiCard.noti.appIcon)
                    implicitSize: 20
                }
            }

            Text {
                id: appNames
                Layout.leftMargin: 10
                text: notiCard.noti?.appName
                color: "#967373"
                font {
                    family: "Firacode Mono Nerd Font"
                    pixelSize: 20
                }
            }
        }

        
    }
}
