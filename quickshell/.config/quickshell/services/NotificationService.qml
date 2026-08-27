
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
            console.log(noti.summary + ": " + noti.body)
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
        let trackedNotis = notificationServer.trackedNotifications.values
        for(let i = 0; i < trackedNotis.length; i++){
            trackedNotis[i].dismiss()
        }
    }

}
