import QtQuick
import "../../../services"
Text{
    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    text: Time.time
    color: "#dddddd"//Dracula.selection
    font.family: "Ticketing"
    font.pixelSize: 14

}
