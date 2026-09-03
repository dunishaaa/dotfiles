pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Networking

Singleton {
    id: root
    property PwNode currentSink: Pipewire.preferredDefaultAudioSink
    property PwNode currentSource: Pipewire.preferredDefaultAudioSource

    PwObjectTracker {
        objects: [root.currentSink, root.currentSource]
    }
}
