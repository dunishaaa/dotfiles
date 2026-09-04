pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Io

//SearchMenu
PanelWindow {
    id: root

    property int searchWidth: menu.width
    property int searchHeight: menu.height

    property bool open: false

    focusable: true
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0

    visible: false
    anchors.bottom: true
    implicitWidth: root.searchWidth
    implicitHeight: root.searchHeight
    color: "transparent"

    IpcHandler {
        target: "appsPanel"

        function open(): void {
            root.open = true;
        }
    }

    onOpenChanged: {
        if (open) {
            handleOpen();
            console.log("Opening...");
        } else {
            handleClosing();
            console.log("Closing...");
        }
    }

    function handleOpen() {
        console.log("handleOpen");

        root.visible = true;

        menuAnimaton.stop();

        menu.y = menu.height;
        slideAnimation.to = 0;
        opacityAnimation.to = 1;
        menuAnimaton.start();
    }

    function handleClosing() {
        console.log("handleClosing");

        root.visible = true;

        menuAnimaton.stop();
        searchBar.inputText.text = "";

        slideAnimation.to = menu.height;
        opacityAnimation.to = 0;
        menuAnimaton.start();
    }

    Rectangle {
        id: menu
        ParallelAnimation {
            id: menuAnimaton
            NumberAnimation {
                id: slideAnimation

                target: menu
                property: "y"

                duration: 500
                easing.type: Easing.OutCubic

                onStarted: console.log("SLIDE STARTED")

                onFinished: {
                    console.log("SLIDE FINISHED");
                }
            }
            NumberAnimation {
                id: opacityAnimation
                target: menu
                property: "opacity"
                duration: 500
                easing.type: Easing.OutCubic
            }
            onFinished: {
                searchBar.inputText.forceActiveFocus();
                if (!root.open) {
                    root.visible = false;
                    console.log("PANEL HIDDEN");
                }
            }
        }

        width: 600//root.searchWidth
        height: 400//root.searchHeight
        topRightRadius: 20
        topLeftRadius: 20
        color: "#8f000212"
        scale: 1.0
        //anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        y: height

        //Enter cooldown
        Timer {
            id: enterCooldowntimer
            interval: 200
            running: false
            onTriggered: {
                root.open = true;
            }
        }

        //exit cooldown
        Timer {
            id: exitCooldownTimer
            interval: 500
            running: false
            onTriggered: {
                root.open = false;
            }
        }

        SearchBar {
            id: searchBar
            onEscapePressed: root.open = false
            onUpPressed: results.selectPrevious()
            onDownPressed: results.selectNext()
            onReturnPressed: {
                results.launchCurrent();
                root.open = false;
            }
            onInputTextChanged: results.currentIndex = 0
        }
        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    enterCooldowntimer.restart();
                    enterCooldowntimer.running = true;
                    exitCooldownTimer.running = false;
                } else {
                    exitCooldownTimer.running = true;
                }
            }
        }
        Rectangle {
            id: applicationsBox
            width: parent.width * 0.94
            height: parent.height * 0.83
            color: "transparent"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: menu.top
            }
            ListView {
                id: results
                currentIndex: 0
                clip: true
                spacing: 15

                anchors {
                    fill: parent
                    topMargin: 20
                }

                function selectNext() {
                    if (currentIndex < count - 1) {
                        currentIndex++;
                    }
                }

                function selectPrevious() {
                    if (currentIndex > 0) {
                        currentIndex--;
                    }
                }

                function launchCurrent() {
                    if (currentItem) {
                        currentItem.launch();
                    }
                }

                //highlight: Rectangle {color: "lightsteelblue"; radius: 5}
                model: {
                    if (searchBar.inputText.text.length === 0) {
                        return DesktopEntries.applications;
                    } else {
                        DesktopEntries.applications.values.filter(app => {
                            return app.name.toLowerCase().includes(searchBar.inputText.text.toLocaleLowerCase());
                        });
                    }
                }
                delegate: ApplicationBox {}
            }
        }
    }
}
