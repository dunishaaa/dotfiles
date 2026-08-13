import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts // for Text
import Quickshell.Io

import Quickshell.Wayland
import Quickshell.Hyprland

import "../../../Palettes"
RowLayout {
    spacing: 5
    anchors {
        leftMargin: 20
        left: bar.left
        verticalCenter: bar.verticalCenter
    }
    Repeater {
        model: Hyprland.workspaces.values.length
        //model: 10
        Rectangle {
            id: wsp

            property bool hovered: false
            width: 14

            scale : hovered || isActive ? 1.3 : 1
            color: isActive || hovered ? Dracula.cyan : "#cc8be8fd"
            height: 15
            radius: 9

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
            //Behavior on color {
            //   NumberAnimation {duration: 1}
            //}

            property var ws: Hyprland.workspaces.values[index]

            property bool isActive: {
                return Hyprland.focusedWorkspace.id === ws.id
            }


            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = ${ws.id}})`)
                onEntered: wsp.hovered = true
                onExited: wsp.hovered = false
            }
        }
    }

}
