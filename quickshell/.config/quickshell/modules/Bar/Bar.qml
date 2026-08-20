pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland

import "Clock"
import "Workspaces"

//Bar.qml
Variants{

    model: Quickshell.screens
    PanelWindow {
        id: panel
        required property var modelData
        screen: modelData

        implicitHeight: 28
        color: "transparent"

        anchors {
            top: true
            right: true
            left: true
        }
        Item{
            anchors.fill: parent
            ClockWidget{}

            Workspaces{monitor: Hyprland.monitorFor(panel.screen)}


        }
    }

}
