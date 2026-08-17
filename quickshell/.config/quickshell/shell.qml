import Quickshell
pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Wayland
import Quickshell.Services.Pipewire



import "modules/Bar"
import "modules/SessionMenu"
import "modules/VolumeStatusBar"
import "modules/SearchMenu"
Scope {
    Bar{}
    SessionMenu{}
    VolumeStatusBar{}
    SearchMenu{}
}
