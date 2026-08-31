
import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../components"

//ApplicationBox
StyledBox{
    id: root
    required property DesktopEntry modelData
    required property int index
    property bool selected: ListView.isCurrentItem
    baseColor: "#ee110e2f"
    hoverColor: "#ee191970"

    scale: selected ? scaleHover:1
    color: selected ? hoverColor:baseColor

    function launch(){
        root.modelData.execute()
    }



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
