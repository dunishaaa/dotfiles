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
        top: true
        right: true
        bottom: true
    }
    color: "transparent"
    implicitWidth: 380
    implicitHeight: 200
    exclusionMode: ExclusionMode.Ignore

    IpcHandler {
        target: "notificationsPanel"
        function toggle(): void{
            root.visible = !root.visible
            panel.forceActiveFocus()
        }
    }

    Rectangle {
        id: panel
        anchors.fill: parent
        color: "#80231e29"
        radius: 16

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
