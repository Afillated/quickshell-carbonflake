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
        property bool closed: false
        property bool ephemeral: false

        property string body: ""
        property string appIcon: ""
        property string appName: ""
        property string summary: ""
        property string image: ""
        property int urgency: NotificationUrgency.Normal
        property real timeout: -1

        readonly property Timer timer: Timer {
            running: notiItem.popout && notiItem.timeout > 0 && !notiItem.dismissed
            interval: notiItem.timeout
            onTriggered: notiItem.dismissed = true
        }

        readonly property Connections conn: Connections {
            target: notiItem.noti
            function onClosed() {
                notiItem.closed = true;
            }
        }

        onDismissedChanged: {
            if (dismissed && ephemeral)
                notiServer.remove(notiItem);
        }

        function close() {
            dismissed = true;
            if (noti)
                noti.dismiss();
        }
    }

    ListModel {
        id: itemsModel
    }

    property alias items: itemsModel

    property bool doNotDisturb: false
    property bool allowCriticalInDND: true
    property bool trackLowUrgency: true
    property real timeoutLow: 5000
    property real timeoutNormal: 10000
    property real timeoutCritical: -1

    property int destroyDelay: 1000

    function isCritical(urgency) {
        return urgency === NotificationUrgency.Critical;
    }

    function resolveTimeout(notification) {
        if (notification.expireTimeout > 0)
            return notification.expireTimeout;

        switch (notification.urgency) {
        case NotificationUrgency.Low:
            return timeoutLow;
        case NotificationUrgency.Critical:
            return timeoutCritical;
        default:
            return timeoutNormal;
        }
    }

    function remove(item) {
        for (let i = 0; i < itemsModel.count; i++) {
            if (itemsModel.get(i).notiItem === item) {
                itemsModel.remove(i);
                item.destroy(destroyDelay);
                return;
            }
        }
    }

    function toggleDND() {
        doNotDisturb = !doNotDisturb;
    }

    function clearNotifications() {
        const doomed = [];
        for (let i = 0; i < itemsModel.count; i++)
            doomed.push(itemsModel.get(i).notiItem);

        itemsModel.clear();

        for (const item of doomed) {
            if (item.noti)
                item.noti.dismiss();
            item.destroy(destroyDelay);
        }
    }

    onDoNotDisturbChanged: {
        if (!doNotDisturb)
            return;

        for (let i = 0; i < itemsModel.count; i++) {
            const item = itemsModel.get(i).notiItem;
            if (item.popout && !item.dismissed && !(allowCriticalInDND && isCritical(item.urgency)))
                item.dismissed = true;
        }
    }

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
        keepOnReload: false

        onNotification: notification => {
            if (!notification)
                return;

            notification.tracked = true;

            const critical = notiServer.isCritical(notification.urgency);
            const suppressPopup = notiServer.doNotDisturb && !(notiServer.allowCriticalInDND && critical);
            const lowUntracked = !notiServer.trackLowUrgency && notification.urgency === NotificationUrgency.Low;

            if (lowUntracked && suppressPopup)
                return;

            const notiItem = notiWrap.createObject(notiServer, {
                popout: !suppressPopup,
                ephemeral: lowUntracked,
                noti: notification,
                body: notification.body,
                appIcon: notification.appIcon,
                appName: notification.appName,
                summary: notification.summary,
                image: notification.image,
                urgency: notification.urgency,
                timeout: notiServer.resolveTimeout(notification)
            });

            itemsModel.insert(0, {
                "notiItem": notiItem
            });
        }
    }

    Component {
        id: notiWrap
        NotificationItem {}
    }
}
