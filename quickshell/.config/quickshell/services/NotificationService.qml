
import QtQuick
import Quickshell.Services.Notifications

// NotificationService.qml
Item{
    id: root
    property alias temporalNotificationModel: temporalModel
    property alias trackedNotifications: notificationServer.trackedNotifications
    ListModel {
        id: temporalModel
    }

    NotificationServer {
        id: notificationServer

        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: noti => {
            console.log("---------------N O T I F I C A T I O N    E N T R Y------------")
            console.log(`id: ${noti.id}`)
            console.log(`summary: ${noti.summary}`)
            console.log(`appName: ${noti.appName}`)
            console.log(`appIcon: ${noti.appIcon}`)
            console.log(`image: ${noti.image}`)
            console.log(`desktopEntry: ${noti.desktopEntry}`)
            console.log(`urgency: ${noti.urgency}`)
            console.log(`hasInlineReply: ${noti.hasInlineReply}`)
            console.log("------------------------------------------------------")
            noti.tracked = true
            temporalModel.insert(0, {
                notification: noti
            })
            console.log("Temporal notifications: ", temporalModel.count)
            console.log("tracked notis: ", trackedNotifications.values.length)
        }

    }

    function removeTemporalNotification(notification){
        for(let i = 0; i < temporalModel.count; ++i){
            if(temporalModel.get(i).notification === notification){
                temporalModel.remove(i)
                return
            }
        }
    }
    function untrackAllNotifications(){
        notificationServer.trackedNotifications.values.map(noti => {
            noti.dismiss()
        })
    }

}
