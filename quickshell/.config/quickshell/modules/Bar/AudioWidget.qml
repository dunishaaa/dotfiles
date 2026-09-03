pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import "../../components"
import "../../services"
import "AudioWidget"

BarBox {
    id: barBox
    boxHeight: parent.height
    boxWidth: sources.width + 30
    enableHover: false

    RowLayout {
        id: sources
        anchors.centerIn: parent
        spacing: 13

        Text {
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
}
