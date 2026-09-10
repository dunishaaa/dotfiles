pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Networking

Singleton {
    id: root
    property PwNode currentSink: Pipewire.defaultAudioSink
    property PwNode currentSource: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [root.currentSink, root.currentSource]
    }
}
