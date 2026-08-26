pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Layouts
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

    visible: open
    anchors.bottom: true
    implicitWidth: root.searchWidth
    implicitHeight: root.searchHeight

    color: "transparent"

    IpcHandler {
        target: "appsPanel"

        function open(): void{
            root.open = true
        }
    }

    onOpenChanged:{
        if(open){
            handleOpen()
        }else{
            handleClosing()
        }
    }

    function handleOpen(){
        searchBar.inputText.forceActiveFocus()
        enterCooldowntimer.running = true
        menu.y = 0
    }
    function handleClosing(){
        menu.y = this.height
        results.currentIndex = 0
        searchBar.inputText.text = ""
    }

    Rectangle {
        id: menu
        Behavior on y {
            NumberAnimation {
                duration: 800
                easing.type: Easing.InQuad
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 450
                easing.overshoot: 1.8
                easing.type: Easing.OutBack
            }
        }
        width: 600//root.searchWidth
        height: 400//root.searchHeight
        topRightRadius: 20
        topLeftRadius: 20
        color: "#8f282a36"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        y: height

        //Enter cooldown
        Timer {
            id: enterCooldowntimer
            interval: 200
            running: false
            onTriggered:{
                root.open = true
            }
        }

        //exit cooldown
        Timer{
            id: exitCooldownTimer
            interval: 500
            running: false
            onTriggered: {
                root.open = false
            }

        }

        Timer {
            id: lowerSearchbar
            interval: exitCooldownTimer.interval - 100
            running: false
            onTriggered: {
            }
        }

        SearchBar{
            id: searchBar
            onEscapePressed: root.open = false
            onUpPressed: results.selectPrevious()
            onDownPressed: results.selectNext()
            onReturnPressed: {
                results.launchCurrent()
                root.open = false
            }
            onInputTextChanged: results.currentIndex = 0
        }
        HoverHandler {
            onHoveredChanged: {
                if(hovered){
                    enterCooldowntimer.restart()
                    enterCooldowntimer.running = true
                    exitCooldownTimer.running = false
                }else{
                    exitCooldownTimer.running = true
                }
            }
        }
        Rectangle {
            id: applicationsBox
            width: parent.width * 0.9
            height: parent.height * 0.83
            color: "transparent"
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            ListView{
                id: results
                currentIndex: 0

                anchors {
                    fill: parent
                    topMargin: 10
                }

                function selectNext() {
                    if (currentIndex < count - 1){
                        currentIndex++
                    }
                }

                function selectPrevious() {
                    if (currentIndex > 0){
                        currentIndex--
                    }
                }

                function launchCurrent() {
                    if (currentItem){
                        currentItem.launch()
                    }
                }
                contentWidth: width
                contentHeight: parent.height
                clip: true
                spacing: 10

                //highlight: Rectangle {color: "lightsteelblue"; radius: 5}
                model: {
                    if(searchBar.inputText.text.length ===  0){
                        return DesktopEntries.applications
                    }else{
                        DesktopEntries.applications.values.filter(app =>{
                            return app.name.toLowerCase().includes(searchBar.inputText.text.toLocaleLowerCase())
                        })
                    }
                }
                delegate: ApplicationBox{}
            }
        }
    }
}
