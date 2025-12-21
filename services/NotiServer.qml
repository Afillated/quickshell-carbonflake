pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.Notifications
import qs.services

Singleton {
    id: notiServer

    component NotificationItem: QtObject {
        id: notiItem

        property Notification noti: null
        property bool popout: false
        readonly property string body: noti.body
        readonly property string appIcon: noti.appIcon
        readonly property string appName: noti.appName
        readonly property string image: noti.image
        readonly property int urgency: noti.urgency
        readonly property real timeout: {
            if (noti.expireTimeout > 0)
                return noti.expireTimeout;
            switch (noti.urgency) {
            case NotificationUrgency.Low:
                return notiServer.timeoutLow;
            case NotificationUrgency.Normal:
                return notiServer.timeoutNormal;
            case NotificationUrgency.Critical:
                return notiServer.timeoutCritical;
            }
        }
        readonly property Timer timer: Timer{
            running: notiItem.timeout > 0;
            interval: notiItem.timeout;
            onTriggered: {
                notiItem.popout = false;
            }
        }
    }

    ListModel {
        id: itemsModel
    }

    property alias items: itemsModel

    property bool doNotDisturb: false
    property bool trackLowUrgency: true
    property real timeoutLow: 5000
    property real timeoutNormal: 8000
    property real timeoutCritical: -1 // do not timeout
    property int maxPopups: 5
    property int maxCenterItems: 100

    NotificationServer {
        id: server
        actionsSupported: false
        actionIconsSupported: true
        persistenceSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodySupported: true
        bodyMarkupSupported: true
        imageSupported: true
        keepOnReload: true

        onNotification: notification => {
            notification.tracked = true;
            if (notification) {
                let notiItem = notiWrap.createObject(notiServer, {
                    popup: true,
                    noti: notification
                });

                itemsModel.insert(0, {
                    "notiItem": notiItem
                });
            }
        }
    }

    function toggleDND() {
        notiServer.doNotDisturb = ! notiServer.doNotDisturb
    }

    function clearNotifications() {
        itemsModel.clear();
    }

    Component {
        id: notiWrap
        NotificationItem {}
    }
}
