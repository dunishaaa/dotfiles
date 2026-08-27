pragma ComponentBehavior: Bound

import QtQuick // for Text
import QtQml
import Quickshell.Services.Notifications
import "../../components"

//NotificationContents.qml
StyledBox {
    id: root
    required property Notification modelData
    property alias slideAnimation: slideOutAnimation

    height:  90

    NumberAnimation {
        id: slideOutAnimation
        target: root
        property: "x"
        duration: 300

    }

    //Notification Image
    Rectangle {
        id: notificationImg
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            margins: 20
        }
        color: "blue"
        height: 50
        width: 50
    }

    Item {
        id: notificationTextBox
        anchors {
            verticalCenter: parent.verticalCenter
            left: notificationImg.right
            margins: 10
        }
        height: 50
        width: 265
        Text {
            id: textSummary
            anchors {
                left: notificationTextBox.left
                margins: 5
            }

            text: root.modelData.summary
            font.family: "Ticketing"
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: bodySummary
            anchors {
                top: textSummary.bottom
                left: notificationTextBox.left
                topMargin: 5
                leftMargin: 5
            }
            text: root.modelData.body
            font.family: "Ticketing"
            color: "white"
        }
    }


}
