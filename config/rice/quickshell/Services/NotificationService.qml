pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQml.Models

Singleton {
    id: root
    property ListModel notifs: ListModel {}
    property ListModel current: ListModel {}

    property bool dnd: false
    property bool showall: false
    property int idCounter: 0

    property var server: NotificationServer {
        bodyMarkupSupported: true
        imageSupported: true
        inlineReplySupported: true
        persistenceSupported: true
        bodySupported: true
        actionsSupported: true
        bodyHyperlinksSupported: true

        onNotification: n => {
            const timeout = (n.expireTimeout > 0 ? n.expireTimeout : 10) * 1000;
            const notif = {
                summary: n.summary || "",
                body: n.body || "",
                image: n.image || "",
                icon: n.appIcon || "",
                expiresAt: !n.lastGeneration ? clock.date.getTime() + timeout : 0,
                trans: n.transient,
                id: root.idCounter,
                notif: n
            };
            root.idCounter++;
            n.tracked = true;
            root.notifs.insert(0, notif);
            if (!n.lastGeneration && !dnd)
                root.current.insert(0, notif);
        }
    }
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    function expire(id: int): void {
        for (var i = 0; i < current.count; i++) {
            if (current.get(i).id == id) {
                current.remove(i);
                return;
            }
        }
    }

    function yeet(id: int): void {
        expire(id);
        for (var i = 0; i < notifs.count; i++) {
            if (notifs.get(i).id == id) {
                notifs.get(i).notif.tracked = false;
                notifs.remove(i);
                return;
            }
        }
    }
}
