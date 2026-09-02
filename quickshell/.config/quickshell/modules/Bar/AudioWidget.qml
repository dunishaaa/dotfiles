pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "AudioWidget"

Item {
    id: root
    required property int boxHeight

    BarBox {
        id: barBox
        boxHeight: root.boxHeight
        boxWidth: sources.width + 30

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
                text: !Pipewire.preferredDefaultAudioSink.audio.muted ? "" : ""
                color: "white"
                font {
                    pixelSize: 12
                }
            }

            Text {
                text: !Pipewire.preferredDefaultAudioSource.audio.muted ? "" : ""
                color: "white"
                font {
                    pixelSize: 12
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                popup.visible = !popup.visible;
            }
        }
    }
    Popup {
        id: popup
        visible: false
    }
}
