pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.theme

ClippingRectangle {
    id: notiCard
    required property var noti
    property real fontSize

    signal clicked
    signal rClicked

    color: Colors.transground3

    border {
        width: 2
        color: Colors.color3
    }

    implicitHeight: cardContent.height + fontSize
    radius: 10

    MouseArea {
        id: closeMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.CrossCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                notiCard.rClicked();
            } else if (mouse.button === Qt.LeftButton) {
                notiCard.clicked();
            }
        }
    }
    ColumnLayout {
        id: cardContent
        anchors {
            verticalCenter: parent.verticalCenter
            margins: 10
        }
        spacing: notiCard.fontSize / 2

        RowLayout {
            id: appDetails
            implicitHeight: notiCard.fontSize * 2
            spacing: notiCard.fontSize / 2
            Layout.leftMargin: notiCard.fontSize / 2
            Loader {
                id: appIcons
                active: notiCard.noti && notiCard.noti?.appIcon
                sourceComponent: Image {
                    source: Quickshell.iconPath(notiCard.noti.appIcon)
                    sourceSize.height: notiCard.fontSize * 1.2
                    sourceSize.width: notiCard.fontSize * 1.2
                }
            }

            Text {
                id: placeholder
                text: ""
                font.pixelSize: notiCard.fontSize * 1.2
                color: Colors.color15
                visible: notiCard.noti && !notiCard.noti?.appIcon
            }
            Text {
                id: appNames
                text: notiCard.noti?.appName
                color: Colors.color15
                font {
                    pixelSize: notiCard.fontSize * 1.2
                }
            }
        }
        RowLayout {
            id: actualNoti
            Layout.fillWidth: true
            spacing: notiCard.fontSize / 2
            Layout.leftMargin: notiCard.fontSize / 2
            Loader {
                id: image
                active: notiCard.noti && notiCard.noti?.image
                Layout.leftMargin: notiCard.fontSize / 2
                sourceComponent: IconImage {
                    source: notiCard.noti.image
                    implicitSize: notiCard.fontSize * 4
                }
            }

            ColumnLayout {
                id: notiContent
                spacing: 0
                Layout.leftMargin: notiCard.fontSize / 2
                Text {
                    id: summary
                    text: notiCard.noti?.summary
                    color: Colors.color15
                    font.weight: Font.Bold
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    textFormat: Text.MarkdownText
                }
                Text {
                    id: body
                    text: notiCard.noti?.body
                    color: Colors.color15
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.maximumWidth: notiCard.width * 0.4
                    Layout.maximumHeight: notiCard.width * 0.4
                    textFormat: Text.MarkdownText
                    Layout.bottomMargin: 10
                    elide: Text.ElideRight
                }
            }
        }
    }
}
