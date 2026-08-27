pragma ComponentBehavior: Bound

import Quickshell
import QtQuick // for Text
import QtQml
import Quickshell.Services.Notifications
import Quickshell.Io

import "../../services"
import "../../components"

PanelWindow {
    id: root
    visible: false
    required property NotificationService notificationService
    anchors {
        right: true
    }
    color: "transparent"
    implicitWidth: 380
    implicitHeight: 800
    exclusionMode: ExclusionMode.Ignore

    IpcHandler {
        target: "notificationsPanel"
        function toggle(): void{
            if(!root.visible){
                console.log("Panel x = " + panel.x)
                console.log("Opening notifications panel")
                root.visible = true
                console.log("2.-Panel x = " + panel.x)
                panel.x = panel.width
                slidePanelAnimation.to = 0
                console.log("Starting opening animation")
                slidePanelAnimation.start()
            }else{
                slidePanelAnimation.stop()
                slidePanelAnimation.to = panel.width
                slidePanelAnimation.start()
            }


        }
    }

    Rectangle {
        id: panel
        width: 380
        height: 800
        color: "#80231e29"
        topLeftRadius: 16
        bottomLeftRadius: 16
        x: width
        NumberAnimation {
            id: slidePanelAnimation
            target: panel
            property: "x"
            duration: 300
            easing.type: Easing.OutCubic
            onFinished: {
                if(panel.x === panel.width){
                    root.visible = false
                }
            }
        }


        StyledBox {
            id: clearBtn
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: 10
                topMargin: 10
            }
            width: clearTxt.width + 20
            height: clearTxt.height + 20

            Text {
                id: clearTxt
                anchors.centerIn: parent
                text: "Clear notifications"
                color: "white"
            }
            mouseArea.onClicked : {
                root.notificationService.untrackAllNotifications()
            }


        }

        Rectangle {
            anchors {
                top: clearBtn.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            color: "transparent"

            ListView {
                id: list
                anchors {
                    fill:parent
                    topMargin: 10
                }
                clip: true
                spacing: 10

                model: root.notificationService.trackedNotifications
                delegate: Item {
                    id: delegateRoot
                    width: list.width
                    height: notificationContents.height
                    required property Notification modelData
                    NotificationContents{
                        id: notificationContents
                        modelData: delegateRoot.modelData
                        width: parent.width - 20
                        x: 10
                        slideAnimation.onFinished : {
                            console.log("Delete animation finished...")
                            modelData.tracked = false
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                notificationContents.hoverable = false
                                notificationContents.clickable = false
                                notificationContents.slideAnimation.stop()
                                notificationContents.slideAnimation.to = parent.width
                                notificationContents.slideAnimation.start()
                            }
                        }
                    }
                }
            }
        }
    }
}
