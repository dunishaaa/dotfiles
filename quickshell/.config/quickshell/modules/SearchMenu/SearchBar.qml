
import QtQuick
import Quickshell.Wayland

//SearchBar
Rectangle {
    id: root
    property TextInput inputText: inputTextComponent
    width: parent.width
    height: parent.height * (1-.83)
    color: "transparent"
    signal escapePressed()

    anchors {
        bottom: parent.bottom
        bottomMargin: 10
    }
    Rectangle{
        id: inputBox
        color: "#88000000"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        height: 50
        width: parent.width * 0.8
        radius: 10
        focus: true
        TextInput {
            id: inputTextComponent
            focus: true

            Keys.onPressed: (event) =>{
                if(event.key == Qt.Key_Escape){
                    root.escapePressed()
                    event.accepted = true
                }
            }

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "white"
            visible: true

            font.family: "Ticketing"
            font.pixelSize: 20
            selectByMouse: true
            onTextChanged: console.log(text)

        }
        Text {
            anchors.left: inputTextComponent.left
            anchors.verticalCenter: inputTextComponent.verticalCenter
            //anchors.leftMargin: root.inputText.anchors.leftMargin

            //verticalAlignment: Text.AlignVCenter

            text: "Search..."
            font: root.inputText.font
            color: "#888888"

            visible: root.inputText.text.length === 0
        }
    }
}
