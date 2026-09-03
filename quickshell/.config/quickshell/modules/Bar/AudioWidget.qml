pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "AudioWidget"
import "../../services"

Item {
    id: root
    required property int boxHeight

    BarBox {
        id: barBox
        boxHeight: root.boxHeight
        boxWidth: sources.width + 30

        /*
        PwObjectTracker {
            id: outputTracker
            objects: [Pipewire.preferredDefaultAudioSink]
        }
        PwObjectTracker {
            id: inputTracker
            objects: [Pipewire.preferredDefaultAudioSource]
        }
        */

        RowLayout {
            id: sources
            anchors.centerIn: parent
            spacing: 13

            Text {
                // text: !Pipewire.preferredDefaultAudioSink.audio.muted ? "" : ""
                text: {
                    if (!Pipewire.ready) {
                        return "";
                    }
                    return !PipewireService.currentSink.audio.muted ? "" : "";
                }
                color: "white"
                font {
                    pixelSize: 12
                }
            }

            Text {
                //text: !Pipewire.preferredDefaultAudioSource.audio.muted ? "" : ""
                text: {
                    if (!Pipewire.ready) {
                        return "";
                    }

                    return !PipewireService.currentSource.audio.muted ? "" : "";
                }
                color: "white"
                font {
                    pixelSize: 12
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("tocasion");
                popup.open = !popup.open;
                barBox.boxWidth = popup.open ? 150 : sources.width + 30;
            }
        }
    }
    Loader {
        active: Pipewire.ready
        sourceComponent: Popup {
            id: popup
        }
    }
}
