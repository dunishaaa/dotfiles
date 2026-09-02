pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

//Popup.qml
Scope {
    id: root
    property PwNode audioSink: Pipewire.preferredDefaultAudioSink
    property PwNode audioSource: Pipewire.preferredDefaultAudioSource
    property bool open: false
    property real width: popup.width
    onOpenChanged: {
        if (open) {
            slideAnimation.stop();
            slideAnimation.from = -popup.height;
            slideAnimation.to = 0;
            shrinkLeft.from = 0;
            shrinkLeft.to = popup.width;
            popup.visible = true;
            box.visible = true;
            audioControllerAnim.start();
        } else {
            slideAnimation.stop();
            slideAnimation.from = 0;
            slideAnimation.to = -popup.height;
            shrinkLeft.from = popup.width;
            shrinkLeft.to = 0;
            slideAnimation.start();
        }
    }

    SequentialAnimation {
        id: audioControllerAnim
        NumberAnimation {
            id: slideAnimation
            target: popup
            property: "y"
            easing.type: Easing.InOutQuad
            easing.overshoot: 40
            duration: 200
        }
        NumberAnimation {
            id: shrinkLeft
            target: popup
            property: "width"

            easing.type: Easing.InOutQuad
            easing.overshoot: 40
            duration: 200
        }
        onFinished: {
            if (!root.open) {
                popup.visible = false;
                box.visible = false;
            }
        }
    }

    PwObjectTracker {
        objects: [root.audioSink, root.audioSource]
    }

    PanelWindow {
        id: box
        color: "transparent"
        implicitHeight: 250
        implicitWidth: 150
        exclusionMode: ExclusionMode.Ignore
        //WlrLayershell.exclusionMode: WlrLayer.Overlay
        visible: false
        anchors {
            top: true
            left: true
        }
        margins {
            left: 155
            top: 20
        }

        Rectangle {
            id: popup
            width: parent.width
            height: parent.height
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
}
