import Quickshell
import QtQuick
import Quickshell.Services.Notifications

Singleton {
    id: notidaemon

    

    NotificationServer {
        actionsSupported: true
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
            
        }
    }
}
