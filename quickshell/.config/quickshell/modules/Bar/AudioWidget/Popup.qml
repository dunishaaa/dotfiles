pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

//Popup.qml
Scope {
    id: root
    property PwNode audioSink: Pipewire.preferredDefaultAudioSink
    property PwNode audioSource: Pipewire.preferredDefaultAudioSource
    required property bool visible
    PwObjectTracker {
        objects: [root.audioSink, root.audioSource]
    }

    PanelWindow {
        id: popup
        visible: root.visible
        color: "transparent"
        implicitHeight: 250
        implicitWidth: 150
        exclusionMode: ExclusionMode.Ignore
        //WlrLayershell.exclusionMode: WlrLayer.Overlay
        anchors {
            top: true
            left: true
        }
        margins {
            top: barBox.y + barBox.height
        }
        RowLayout {
            anchors.centerIn: parent
            spacing: 20
            AudioController {
                id: speakerController
                controllerWidth: popup.width * 0.3
                controllerHeight: popup.height * 0.9
                backgroundColor: "#80282a36"
                audioSource: root.audioSink
                unMutedIcon: ""
                mutedIcon: ""
                iconColor: "white"
                iconPixelSize: 22
            }

            AudioController {
                id: microphoneController
                controllerWidth: popup.width * 0.3
                controllerHeight: popup.height * 0.9
                backgroundColor: "#80282a36"
                audioSource: root.audioSource
                unMutedIcon: ""
                mutedIcon: ""
                iconColor: "white"
                iconPixelSize: 22
            }
        }
    }
}
