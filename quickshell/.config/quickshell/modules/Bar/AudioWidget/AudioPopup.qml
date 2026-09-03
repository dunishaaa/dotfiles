pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../../services"
import "../../../components"

//AudioPopup.qml
Popup {

    DropdownBox {
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
