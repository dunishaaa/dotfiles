pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../../services"
import ".."

//Popup.qml
Scope {
    id: root
    property bool open: false
    property real width: box.implicitWidth
    property Item itemToAttach
    required property NumberAnimation shrinkAnim
    onOpenChanged: {
        if (open) {
            slideAnimation.stop();
            slideAnimation.from = -popup.height;
            slideAnimation.to = 0;
            popup.visible = true;
            box.visible = true;
            audioControllerAnim.start();
        } else {
            slideAnimation.stop();
            slideAnimation.from = 0;
            slideAnimation.to = -popup.height;
            audioControllerAnim.start();
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
        onFinished: {
            if (!root.open) {
                popup.visible = false;
                box.visible = false;
                root.shrinkAnim.start();
            } else {}
        }
    }

    PopupWindow {
        id: box
        color: "transparent"
        implicitHeight: 250
        implicitWidth: 150
        visible: false
        anchor.item: root.itemToAttach

        BarBox {
            id: popup
            boxHeight: parent.height
            boxWidth: parent.width
            width: parent.width
            height: parent.height
            y: 0
            visible: false
            enableHover: false

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
