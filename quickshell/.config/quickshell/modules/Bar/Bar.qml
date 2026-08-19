pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.Pipewire

import "Clock"
import "Workspaces"
import "Volume"


Variants{

    model: Quickshell.screens
    PanelWindow {
        id: panel
        required property var modelData
        screen: modelData

        implicitHeight: 28
        color: "transparent"
        //color: "#0000ff"

        anchors {
            top: true
            right: true
            left: true
        }
        margins {
            bottom: 5
        }
        Item{
            anchors.fill: parent
            Rectangle {
                id: centerBar
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                //radius: 16
                bottomLeftRadius: 16
                bottomRightRadius: 16
                color: "#7f282a36"
                height: panel.implicitHeight
                width: 80
                //color: "#ff0000"
                ClockWidget {}
                //SessionButton{
                 //   id: sessionButton
                //}
            }

            Rectangle {
                id: leftBar
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                Behavior on width {
                    NumberAnimation {
                        duration: 100
                        easing.overshoot: 20
                        easing.type: Easing.OutCubic
                    }
                }

                height: panel.implicitHeight
                width: 30+(workspaces.activeWorkspaces * 10) + (workspaces.activeWorkspaces * 5)
                //radius: 16
                bottomLeftRadius: 16
                bottomRightRadius: 16
                color: "#7f282a36"
                //color: "#ff0000"
                Workspaces{
                    id: workspaces
                    monitor: Hyprland.monitorFor(panel.screen)
                }
            }

        }
    }

}
