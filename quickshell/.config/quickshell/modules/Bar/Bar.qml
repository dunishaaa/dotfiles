pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland

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

            /*
            PopupWindow {
                id: expandedClock

                anchor {
                    window: panel
                    rect.x: panel.width / 2 - width/2
                }

                color: "transparent"

                implicitWidth: clock.width + 30
                implicitHeight: 100

                visible: clock.hovered

                BarBox {
                    anchors.horizontalCenter: parent.horizontalCenter

                    boxHeight: 100
                    width: popupText.width + 30//parent.implicitWidth
                    Text {
                        id: popupText
                        anchors.centerIn: parent
                        text: Time.giveTimeFormat("full")
                        color: "white"
                        font.family: "Ticketing"
                        font.pixelSize: 20
                    }
                }
            }
            */


            Workspaces{monitor: Hyprland.monitorFor(panel.screen)}
            SessionButton{}
        }
    }
}
