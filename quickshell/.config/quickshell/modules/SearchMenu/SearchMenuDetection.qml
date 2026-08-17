import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow{
    id: root
    required property SearchMenu searchMenu
    visible: true
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0

    anchors.bottom: true
    color: "transparent"
    implicitWidth: 600
    implicitHeight: 5
    Rectangle {
        id: menu
        property bool hover: false
        Behavior on y {
            NumberAnimation {duration: 200}
        }
        width: root.searchMenu.searchWidth
        height: root.searchMenu.searchHeight
        topRightRadius: 20
        topLeftRadius: 20
        color: "#8f282a36"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: detectionBoxTimer.running = true
            onExited: detectionBoxTimer.running = false

        }

        Timer {
            id: detectionBoxTimer
            interval: 200
            running: false
            onTriggered: root.searchMenu.visible = true
        }
    }

}
