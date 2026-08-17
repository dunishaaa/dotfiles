import QtQuick
import Quickshell.Services.Pipewire
Text {
    text: {
        let vol = Math.round(Pipewire.preferredDefaultAudioSink.audio.volume*100)
        if(Pipewire.preferredDefaultAudioSink.audio.muted){
            return ""
        }else if(vol<= 15){
            return ""
        }else if(vol<= 30){
            return ""
        }else if(vol<= 50){
            return ""
        }else{
            return ""
        }
    }
    color: "white"
    font.family: "Ticketing"
    font.pixelSize: 15
    anchors {
        verticalCenter: parent.verticalCenter
        right: sessionButton.left
        margins: 10
    }
    PwObjectTracker {
        objects: [Pipewire.preferredDefaultAudioSink]
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            Pipewire.preferredDefaultAudioSink.audio.muted = !Pipewire.preferredDefaultAudioSink.audio.muted
        }
    }
}
