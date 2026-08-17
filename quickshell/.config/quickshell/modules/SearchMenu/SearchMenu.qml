
import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0

    anchors.bottom: true
    color: "transparent"
    width: 800
    height: 400
    Rectangle {
        id: menu
        property bool hover: false
        Behavior on y {
            NumberAnimation {duration: 200}
        }
        width: 800
        height: 400
        topRightRadius: 20
        topLeftRadius: 20
        color: "#80000000"
        y: hover ? 2 : this.height - 5
        //y: 390
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: menu.hover = true //enty coodown
            onExited: menu.hover = false //exit cooldown
        }
    }
    //Enter cooldown
    //Timer

    //exit cooldown
    //Timer

}
