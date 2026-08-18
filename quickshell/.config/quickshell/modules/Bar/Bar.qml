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
            right: 300
            left: 300
            //top: 5
            bottom: 5
        }
        Rectangle {
            id: bar
            anchors.fill: parent
            //radius: 16
            bottomLeftRadius: 16
            bottomRightRadius: 16
            color: "#7f282a36"
            //color: "#ff0000"
            Workspaces{
                monitor: Hyprland.monitorFor(panel.screen)
            }
            ClockWidget {}
            Volume {}
            SessionButton{
                id: sessionButton
            }
        }
    }
}
