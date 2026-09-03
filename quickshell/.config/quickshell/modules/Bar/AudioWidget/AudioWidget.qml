pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import "../../../components"
import "../../../services"

BarBox {
    id: root
    boxHeight: parent.height
    boxWidth: sources.width + 30
    enableHover: false
    extendedWidth: popup.width
    enablePopup: true

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
    popup: Popup {
        id: popup
        itemToAttach: root
        DropdownBox {
            width: popup.width
            height: popup.height
            y: 0
            visible: false

            RowLayout {
                anchors.centerIn: parent
                spacing: 20
                AudioController {
                    id: speakerController
                    controllerWidth: popup.width * 0.3
                    controllerHeight: popup.height * 0.9
                    backgroundColor: "#80282a36"
                    audioSource: PipewireService.currentSink
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
                    audioSource: PipewireService.currentSource
                    unMutedIcon: ""
                    mutedIcon: ""
                    iconColor: "white"
                    iconPixelSize: 22
                }
            }
        }
    }
}
