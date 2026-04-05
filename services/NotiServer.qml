pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.Notifications

Singleton {
    id: notiServer

    component NotificationItem: QtObject {
        id: notiItem

        property Notification noti: null
        property bool popout: false
        property bool dismissed: false
        readonly property string body: noti.body
        readonly property string appIcon: noti.appIcon
        readonly property string appName: noti.appName
        readonly property string summary: noti.summary
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
        readonly property Timer timer: Timer {
            running: notiItem.timeout > 0 && !notiItem.dismissed
            interval: notiItem.timeout
            onTriggered: notiItem.dismissed = true
        }
    }

    ListModel {
        id: itemsModel
    }

    property alias items: itemsModel

    property bool doNotDisturb: false
    property bool trackLowUrgency: true
    property real timeoutLow: 5000
    property real timeoutNormal: 10000
    property real timeoutCritical: -1 
    property int maxPopups: 5
    property int maxCenterItems: 100

    NotificationServer {
        id: server
        actionsSupported: true
        actionIconsSupported: true
        persistenceSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodySupported: true
        bodyMarkupSupported: true
        imageSupported: true
        keepOnReload: false

        onNotification: notification => {
            notification.tracked = true;
            if (notification) {
                let notiItem = notiWrap.createObject(notiServer, {
                    popout: true,
                    noti: notification
                });

                itemsModel.insert(0, {
                    "notiItem": notiItem
                });
            }
        }
    }

    function toggleDND() {
        notiServer.doNotDisturb = !notiServer.doNotDisturb;
    }

    function clearNotifications() {
        itemsModel.clear();
    }

    Component {
        id: notiWrap
        NotificationItem {}
    }
}
