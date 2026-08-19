
import QtQuick
import Quickshell
import Quickshell.Widgets

//ApplicationBox
Rectangle{
    id: root
    required property DesktopEntry modelData
    required property int index
    property bool hovered: false
    property bool selected: ListView.isCurrentItem

    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing.type: Easing.InQuad
        }
    }

    function launch(){
        root.modelData.execute()
    }


    radius: 5
    color: hovered || selected ? "#383A45" :"#ff282a36"
    scale: hovered || selected ? 1.03 : 1

    width: menu.width * 0.87
    height: root.width / 9
    anchors.horizontalCenter: parent.horizontalCenter
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
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: appIcon.right
        anchors.leftMargin: 10
        text: root.modelData.name
        color: "white"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.launch()

    }
}
