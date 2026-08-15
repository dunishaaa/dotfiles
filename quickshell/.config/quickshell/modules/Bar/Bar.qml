pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland
import Quickshell.Io

import "Clock"
import "Workspaces"


Scope {
    id: root
    Variants{

        model: Quickshell.screens
        PanelWindow {
            id: panel
            required property var modelData
            screen: modelData

            implicitHeight: 25
            color: "transparent"
            //color: "#0000ff"

            anchors {
                top: true
                right: true
                left: true
            }
            margins {
                right: 500
                left: 500
                top: 5
                bottom: 5
            }
            Rectangle {
                id: bar
                anchors.fill: parent
                radius: 16
                color: "#7f282a36"
                //color: "#ff0000"
                Workspaces{
                    monitor: Hyprland.monitorFor(panel.screen)
                }
                ClockWidget {}
                SessionButton{}
            }
        }
    }
}
