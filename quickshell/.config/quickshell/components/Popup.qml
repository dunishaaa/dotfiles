pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../components"

//Popup.qml
PopupWindow {
    id: root

    color: "transparent"

    implicitHeight: 250
    implicitWidth: 150

    anchor.item: root.itemToAttach

    visible: false
    property Item itemToAttach
    property bool open: false
    property Item popup

    signal shown
    signal hidden

    NumberAnimation {
        id: slideAnimation
        target: root.popup
        property: "y"
        easing.type: Easing.InOutQuad
        easing.overshoot: 40
        duration: 200
        onFinished: {
            if (root.open) {
                root.shown();
            } else {
                root.visible = false;
                root.hidden();
            }
        }
    }
    /*
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
    */

    function show() {
        root.visible = true;
        root.popup.visible = true;
        slideAnimation.stop();
        slideAnimation.from = -root.popup.height;
        slideAnimation.to = 0;
        slideAnimation.start();
    }

    function hide() {
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
