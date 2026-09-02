pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Networking

import "Clock"
import "Workspaces"
import "../../services/"

//Bar.qml
Variants {

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
        Item {
            anchors.fill: parent

            ClockWidget {
                id: clock
            }
            Workspaces {
                id: workspaces
                monitor: Hyprland.monitorFor(panel.screen)
            }
            SessionButton {
                id: sessionButton
            }
            UtilitiesWidget {
                id: utilities
                boxHeight: 28
                width: utilities.utilitiesWidth + 30
                anchors.right: sessionButton.left
                anchors.rightMargin: 45
            }

            AudioWidget {
                id: audio
                boxHeight: 28
                width: audio.sourceWidth + 30
                anchors.left: workspaces.right
                anchors.leftMargin: 45
            }
        }
    }
}
