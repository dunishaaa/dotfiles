pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Mpris
import "../../../services"
import "../../../components"

AudioFrequencies {
    id: root

    onOpenChanged: {
        //
        if (root.open) {
            root.visible = true;
            root.open = true;
            fadeAnimation.stop();
            fadeAnimation.from = 0;
            fadeAnimation.to = 1;
            fadeAnimation.start();
        } else {
            root.open = false;
            fadeAnimation.stop();
            fadeAnimation.from = 1;
            fadeAnimation.to = 0;
            fadeAnimation.start();
            //root.visible = false;
        }
    }

    NumberAnimation {
        //

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
