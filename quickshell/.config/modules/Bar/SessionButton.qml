
import QtQuick
Text {
    text: "session"
    color: "#FFFFFF"
    font.family: "Ticketing"
    font.pixelSize: 20
    anchors {
        right: bar.right
        verticalCenter: bar.verticalCenter
        rightMargin: 20
    }
    MouseArea {
        anchors.fill: parent
        onClicked: notification.running = true
    }
}
