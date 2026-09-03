pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import "../services"
import "../components"

//Popup.qml
Scope {
    id: root
    required property NumberAnimation shrinkAnim
    property Item itemToAttach
    property bool open: false

    property real height: 250
    property real width: 150

    signal shown
    signal hidden

    function show() {
        popup.visible = true;
        slideAnimation.stop();
        slideAnimation.from = -popup.height;
        slideAnimation.to = 0;
        slideAnimation.start();
    }

    function hide() {
        slideAnimation.stop();
        slideAnimation.from = 0; //popup.y
        slideAnimation.to = -popup.height;
    }

    /*
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
    */

    NumberAnimation {
        id: slideAnimation
        target: popup
        property: "y"
        easing.type: Easing.InOutQuad
        easing.overshoot: 40
        duration: 200
        onFinished: {
            if (root.open) {
                root.shown();
            } else {
                popupWindow.visible = false;
                root.hidden();
            }
        }
    }

    PopupWindow {
        id: popupWindow

        color: "transparent"

        implicitHeight: root.height
        implicitWidth: root.width

        anchor.item: root.itemToAttach

        visible: false

        Item {
            id: popup
            width: parent.implicitWidth
            height: parent.implicitHeight
            DropdownBox {
                anchors.fill: parent
                visible: false
            }
        }
    }
    onOpenChanged: {
        if (open)
            show();
        else
            hide();
    }
}
