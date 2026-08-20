import Quickshell
pragma ComponentBehavior: Bound
import QtQuick // for Text
import Quickshell.Wayland

import "modules/Bar"
import "modules/SessionMenu"
import "modules/VolumeStatusBar"
import "modules/SearchMenu"

Scope {
    /*
    PanelWindow{

        Rectangle{
            anchors.centerIn: parent
            width: 20
            height: 20
            color: "red"
            scale: hover.hovered ? 3.5: 1
            Behavior on scale {
                NumberAnimation {duration: 100}
            }
            HoverHandler{
                id: hover

            }
        }
    }
    */

    Bar{id: bar}
    SessionMenu{}
    VolumeStatusBar{}
    SearchMenu{
        id: searchMenu
    }
    SearchMenuDetection{
        searchMenu: searchMenu
    }

}
