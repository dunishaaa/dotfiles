pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick // for Text
import QtQuick.Layouts // for Text

import "../../../Palettes"
import "../"

BarBox {
    id: root

    required property HyprlandMonitor monitor

    width: {
        return 30 + (rowLayout.activeWorkspaces * rowLayout.workspaceWidth) + (rowLayout.activeWorkspaces * rowLayout.spacing);
    }

    RowLayout {
        id: rowLayout
        property int activeWorkspaces
        property int workspaceWidth: 10
        spacing: 5
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        Repeater {
            model: Hyprland.workspaces.values.filter(ws => ws.monitor === root.monitor)
            onCountChanged: rowLayout.activeWorkspaces = count
            Rectangle {
                id: wsp
                required property int index
                required property HyprlandWorkspace modelData
                property bool hovered: false

                width: rowLayout.workspaceWidth
                height: 10
                radius: 9

                scale: hovered || isActive ? 1.3 : 1
                color: isActive || hovered ? Dracula.cyan : "#888be8fd"

                Behavior on scale {
                    NumberAnimation {
                        duration: 150
                    }
                }
                Behavior on width {
                    NumberAnimation {
                        duration: 150
                    }
                }

                property bool isActive: {
                    return modelData.focused;
                }
                Text {
                    anchors.centerIn: parent
                    text: wsp.modelData.id
                    font.pixelSize: 7
                    font.family: "mono"
                    opacity: 0.6
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
}
