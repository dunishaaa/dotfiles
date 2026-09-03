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
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!popup.open) {
                    widenAnim.start();
                } else {
                    popup.open = false;
                }
            }
        }
        NumberAnimation {
            id: widenAnim
            target: barBox
            property: "boxWidth"
            easing.type: Easing.InOutQuad
            duration: 100
            from: sources.width + 30
            to: popup.width
            onFinished: {
                popup.open = true;
            }
        }
        NumberAnimation {
            id: shrinkAnim
            target: barBox
            property: "boxWidth"
            easing.type: Easing.InOutQuad
            duration: 100
            from: popup.width
            to: sources.width + 30
            onFinished: {}
        }
    }
    Popup {
        id: popup
        itemToAttach: root
        shrinkAnim: shrinkAnim
    }
}
