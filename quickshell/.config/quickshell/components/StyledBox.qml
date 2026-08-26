import QtQuick

Rectangle{
    id: root
    property bool hoverable: true
    property bool clickable: true
    property string baseColor:"#ee282a36"
    property string hoverColor: "#ee2a2c38"
    property string clickedColor: "#ee2e303c"
    property int styledRadius: 10
    property real scaleHover: 1.07
    property real scaleClicked: 1.15


    color: baseColor
    radius: styledRadius

    Behavior on scale {
        NumberAnimation {duration: 100}
    }
    HoverHandler{
        id: hoverHandler
        enabled: root.hoverable
        onHoveredChanged:{
            root.scale = hovered ? root.scaleHover : 1
            root.color = hovered ? root.hoverColor: root.baseColor
        }
    }
    MouseArea {
        id: mouseArea
        enabled: root.clickable
        anchors.fill: parent
        onClicked: {
            root.scale = clicked ? root.scaleClicked: 1
            root.color = clicked? root.clickedColor : root.baseColor
        }
    }
}
