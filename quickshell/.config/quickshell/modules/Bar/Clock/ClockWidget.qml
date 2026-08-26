import QtQuick
import "../../../services"
import "../"

//ClockWidget.qml
BarBox {
    id: root
    boxHeight: parent.height
//    property bool hovered: hoverHandler.hovered
    width: {
        if(timeFormat == "full"){
            return fullTimeText.width + 40
        }else{
            return timeText.width + 40
        }
    }

    property string timeFormat: "time"

       anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }

    Text{
        id: timeText

        Behavior on opacity{
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        anchors.centerIn: parent

        text: Time.giveTimeFormat("time")

        color: "#dddddd"//Dracula.selection
        font.family: "Ticketing"
        font.pixelSize: 14

        opacity: root.timeFormat === "time" ? 1 : 0



    }
    Text {
        id: fullTimeText

        Behavior on opacity{
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        anchors.centerIn: parent

        text: Time.giveTimeFormat("full")

        color: "#dddddd"//Dracula.selection
        font.family: "Ticketing"
        font.pixelSize: timeText.font.pixelSize + 3

        opacity: root.timeFormat === "full" ? 1 : 0




    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(root.timeFormat == "full"){
                root.timeFormat = "time"
            }else{
                root.timeFormat = "full"
            }
        }
    }

}
