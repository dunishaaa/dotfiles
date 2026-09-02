pragma ComponentBehavior: Bound

import QtQuick
import "../../../services"
import "../../../components"

AudioFrequencies {
    id: root

    onOpenChanged: {
        if (CavaService.isAudioPlaying()) {
            root.visible = true;
            fadeAnimation.stop();
            fadeAnimation.from = 0;
            fadeAnimation.to = 1;
            fadeAnimation.start();
        } else {
            fadeAnimation.stop();
            fadeAnimation.from = 1;
            fadeAnimation.to = 0;
            fadeAnimation.start();
            //root.visible = false;
        }
    }
    Timer {
        id: checkSound
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            root.open = CavaService.isAudioPlaying();
        }
    }

    NumberAnimation {
        id: fadeAnimation
        target: root
        property: "opacity"
        duration: 200
        onFinished: {
            if (!root.open) {
                root.visible = false;
            }
        }
    }
}
