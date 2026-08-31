pragma ComponentBehavior: Bound
import QtQuick // for Text
import Quickshell.Services.Pipewire
import QtQuick.Layouts


BarBox{
    property real sourceWidth: sources.width
    PwObjectTracker {
        id: outputTracker
        objects: [Pipewire.preferredDefaultAudioSink]
    }
    PwObjectTracker {
        id: inputTracker
        objects: [Pipewire.preferredDefaultAudioSource]
    }

    RowLayout {
        id: sources
        anchors.centerIn: parent
        spacing: 13

        Text {
            text: !Pipewire.preferredDefaultAudioSource.audio.muted?"":""
            color: "white"
            font{
                pixelSize: 12
            }
        }

        Text {
            text: !Pipewire.preferredDefaultAudioSink.audio.muted ? "": ""
            color: "white"
            font{
                pixelSize: 12
            }
        }

    }


}
