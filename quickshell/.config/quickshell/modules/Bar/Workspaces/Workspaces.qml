import Quickshell // for PanelWindow
import Quickshell.Hyprland
import QtQuick // for Text
import QtQuick.Layouts // for Text


import "../../../Palettes"
RowLayout {
    id: root
    required property HyprlandMonitor monitor
    property int activeWorkspaces
    spacing: 5
    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    Repeater {
        model: Hyprland.workspaces.values.filter(ws => ws.monitor === root.monitor)
        onCountChanged: root.activeWorkspaces = count
        Rectangle {
            id: wsp
            required property int index
            required property HyprlandWorkspace modelData
            property bool hovered: false

            width: 10
            height: 10
            radius: 9

            scale: hovered || isActive ? 1.3 : 1
            color: isActive || hovered ? Dracula.cyan : "#888be8fd"

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
            Behavior on width{
               NumberAnimation {duration: 150}
            }


            property bool isActive: {
                return modelData.focused;
            }


            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = ${wsp.modelData.id}})`)
                onEntered: wsp.hovered = true
                onExited: wsp.hovered = false
            }
        }
    }

}
