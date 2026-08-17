import Quickshell
pragma ComponentBehavior: Bound
import QtQuick // for Text
import Quickshell.Wayland

import "modules/Bar"
import "modules/SessionMenu"
import "modules/VolumeStatusBar"
import "modules/SearchMenu"

Scope {
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
