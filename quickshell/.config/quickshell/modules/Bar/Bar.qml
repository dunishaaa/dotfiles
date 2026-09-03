pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Networking

import "CentralWidget"
import "Workspaces"
import "AudioWidget"
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

            CentralWidget {
                id: clock
                boxHeight: parent.height
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
            }
            Workspaces {
                id: workspaces
                monitor: Hyprland.monitorFor(panel.screen)
                boxHeight: parent.height * 0.9
                anchors {
                    left: parent.left
                    leftMargin: 20
                }
            }
            SessionButton {
                id: sessionButton
                boxHeight: parent.height * 0.9
                anchors {
                    right: parent.right
                    rightMargin: 20
                }
            }
            UtilitiesWidget {
                id: utilities
                boxHeight: parent.height * 0.9
                boxWidth: utilities.utilitiesWidth + 30
                anchors.right: sessionButton.left
                anchors.rightMargin: 45
            }

            AudioWidget {
                id: audio
                boxHeight: parent.height * 0.9
                anchors.left: workspaces.right
                anchors.leftMargin: 45
            }
        }
    }
}
