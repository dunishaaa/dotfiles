
import QtQuick
import Quickshell.Io
import "../SessionMenu"
Text {
    id: root
    property bool hovered: false
    text: "󰩃"
    color: "#FFFFFF"
    font.family: "Ticketing"
    font.pixelSize: 20
    scale: hovered? 1.3:1
    Behavior on scale{
        NumberAnimation { duration: 150 }
    }

    anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 20
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            SessionState.open = !SessionState.open
        }

        onEntered: {
            root.hovered = true
        }
        onExited: root.hovered = false
    }
}
