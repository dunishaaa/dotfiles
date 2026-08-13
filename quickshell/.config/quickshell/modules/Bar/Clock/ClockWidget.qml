import QtQuick
import "../../../Palettes/"
Text{
    anchors {
        verticalCenter: bar.verticalCenter
        horizontalCenter: bar.horizontalCenter
    }
    text: Time.time
    color: "#dddddd"//Dracula.selection
    font.family: "Ticketing"
    font.pixelSize: 24

}
