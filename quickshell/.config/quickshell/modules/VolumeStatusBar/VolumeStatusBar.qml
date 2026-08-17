import Quickshell
pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Wayland
import Quickshell.Services.Pipewire



PanelWindow {
    id: audio

    visible: false

    anchors.bottom: true
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0

    color: "transparent"
    width: 200
    height: 70
    margins.bottom: 50

    PwObjectTracker {
        id: volumeTracker
        objects: [Pipewire.preferredDefaultAudioSink]
    }

    Connections {
        target: Pipewire.preferredDefaultAudioSink.audio
        function onVolumeChanged(){
            audio.visible = true
            audioPanel.scale = 1
            volumePanelTimer.restart()
        }
        function onMutedChanged(){
            audio.visible = true
            volumePanelTimer.restart()
        }
    }

    Rectangle {
        id: audioPanel
        anchors.fill: parent
        color: "#8f282a36"
        radius: 5
        Rectangle {
            color: "#00ff00"
            height: 5
            width: parent.width - 30
            radius: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -10
            Rectangle {
                anchors.left: parent.left
                height: 5
                radius: 15
                Behavior on width{
                    NumberAnimation {duration: 100}
                }
                width: {
                    let vol = Pipewire.preferredDefaultAudioSink.audio.volume
                    return parent.width * vol

                }
            }
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 15

            id: volumeText
            font.family: "Ticketing"
            font.pixelSize: Pipewire.preferredDefaultAudioSink.audio.muted?20:12
            text: {
                if(Pipewire.preferredDefaultAudioSink.audio.muted){
                    return ""
                }
                return Math.round(Pipewire.preferredDefaultAudioSink.audio.volume*100)
            }
            color: "white"
        }
    }
    Timer {
        id: volumePanelTimer
        interval: 1000
        running: false
        onTriggered: audio.visible = false
    }
}
