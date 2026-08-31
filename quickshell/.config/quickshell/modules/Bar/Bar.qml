pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland
import Quickshell.Networking

import "Clock"
import "Workspaces"
import "../../services/"

//Bar.qml
Variants{

    model: Quickshell.screens
    PanelWindow {
        id: panel
        required property var modelData
        screen: modelData

        implicitHeight: 28
        color: "transparent"
        //color: "blue"

        anchors {
            top: true
            right: true
            left: true
        }
        Item{
            anchors.fill: parent

            ClockWidget{id: clock}
            Workspaces{
                id: workspaces
                monitor: Hyprland.monitorFor(panel.screen)
            }
            SessionButton{id: sessionButton}
            UtilitiesWidget{
                id: utilitiesWidget
                boxHeight: 28
                width: utilitiesWidget.utilitiesWidth + 30
                anchors.right: sessionButton.left
                anchors.rightMargin: 10
            }

        }
    }
}
