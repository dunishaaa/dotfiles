import QtQuick
import Quickshell.Io
import "../SessionMenu"

BarBox {
    id: root

    property bool hovered: false

    width: textItem.width + 30

    Text {
        id: textItem

        anchors {
            right: parent.right
            centerIn: parent
            rightMargin: 26
        }

        Behavior on scale {
            NumberAnimation {
                duration: 155
            }
        }

        text: "󰩃"
        color: "#FFFFFF"
        font.family: "Ticketing"
        font.pixelSize: 21
        scale: root.hovered ? 1.2 : 1
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            SessionState.open = !SessionState.open;
        }

        onEntered: root.hovered = true
        onExited: root.hovered = false
    }
}
