pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../components"

//Popup.qml
PopupWindow {
    id: root

    color: "white"

    implicitHeight: 250
    implicitWidth: 150

    anchor.item: root.itemToAttach

    visible: false
    property Item itemToAttach
    property bool open: false

    signal shown
    signal hidden

    NumberAnimation {
        id: slideAnimation
        target: popup
        property: "y"
        easing.type: Easing.InOutQuad
        easing.overshoot: 40
        duration: 200
        onFinished: {
            if (root.open) {
                console.log("down");
                root.shown();
            } else {
                root.visible = false;
                console.log("down");
                root.hidden();
            }
        }
    }

    Item {
        id: popup
        width: parent.implicitWidth
        height: parent.implicitHeight
        y: 0
        DropdownBox {
            anchors.fill: parent
            visible: true
        }
    }

    function show() {
        console.log("Going down");
        root.visible = true;
        popup.visible = true;
        slideAnimation.stop();
        slideAnimation.from = -popup.height;
        slideAnimation.to = 0;
        slideAnimation.start();
    }

    function hide() {
        console.log("Going up");
        slideAnimation.stop();
        slideAnimation.from = 0; //popup.y
        slideAnimation.to = -popup.height;
        slideAnimation.start();
    }

    onOpenChanged: {
        if (open)
            show();
        else
            hide();
    }
}
