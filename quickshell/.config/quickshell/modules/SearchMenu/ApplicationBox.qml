
import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle{
    id: root
    required property DesktopEntry modelData
    property bool hovered: false
    Behavior on scale {
        NumberAnimation {duration: 100}
    }

    radius: 5
    color: hovered ? "#383A45" :"#ff282a36"
    scale: hovered ? 1.03 : 1

    width: menu.width * 0.87
    height: root.width / 9
    IconImage {
        id: appIcon
        anchors {
            left: root.left
            verticalCenter: root.verticalCenter
            leftMargin: 10
        }
        implicitSize: 32
        source: Quickshell.iconPath(root.modelData.icon, "application-x-executable")
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: root.modelData.name
        color: "white"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: {
            root.modelData.execute()
        }
    }
}
