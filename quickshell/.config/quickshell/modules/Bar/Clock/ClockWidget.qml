import QtQuick
import "../../../services"
import "../"
BarBox {
    id: root
    boxHeight: parent.height
    width: {
        return (hoverHandler.hovered? fullTimeText.width : timeText.width) + 40
    }

    property string timeFormat: "time"


    anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }

    Text{
        id: timeText

        anchors.centerIn: parent

        text: Time.giveTimeFormat("time")

        color: "#dddddd"//Dracula.selection
        font.family: "Ticketing"
        font.pixelSize: 14

        opacity: root.timeFormat === "time" ? 1 : 0

        Behavior on opacity{
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    }
    Text {
        id: fullTimeText
        anchors.centerIn: parent

        text: Time.giveTimeFormat("full")

        color: "#dddddd"//Dracula.selection
        font.family: "Ticketing"
        font.pixelSize: 14

        opacity: root.timeFormat === "full" ? 1 : 0

        Behavior on opacity{
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    }

    HoverHandler{
        id: hoverHandler
        onHoveredChanged: {
            root.timeFormat = hovered ? "full":"time"
        }

    }

}
