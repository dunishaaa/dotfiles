pragma ComponentBehavior: Bound

import Quickshell
import QtQuick // for Text
import Quickshell.Services.Notifications
import QtQml

import "../../services"

PanelWindow {
    id: root
    visible: notificationService.temporalNotificationModel.count > 0

    required property NotificationService notificationService
    anchors {
        top: true
        right: true
        bottom: true
    }
    color: "transparent"
    margins {
        top: 31
        bottom: 32
        right: 10
    }
    implicitWidth: 380
    implicitHeight: 200
    exclusionMode: ExclusionMode.Ignore

    ListView {
        id: list

        anchors {
            fill: parent
            topMargin: 10
        }

        clip: true
        spacing: 10

        model: root.notificationService.temporalNotificationModel

        delegate: NotificationContents{
            id: notificationContents
            required property var notification
            modelData: notification
            Timer {
                interval: 5000
                running: true
                repeat: false

                onTriggered: {
                    root
                        .notificationService
                        .removeTemporalNotification(notificationContents.notification)
                }

            }
        }
    }


}
