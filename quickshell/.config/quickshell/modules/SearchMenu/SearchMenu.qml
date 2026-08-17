pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Layouts
import Quickshell.Io


//SearchMenu
PanelWindow {
    id: root

    property int searchWidth: 600
    property int searchHeight: 400

    property bool open: false

    focusable: true
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0


    visible: open
    anchors.bottom: true
    color: "transparent"
    implicitWidth: root.searchWidth
    implicitHeight: root.searchHeight

    Item {
        id: keyHandler
        anchors.fill: parent
        focus: true
        Keys.onPressed: (event) =>{
            if(event.key == Qt.Key_Escape){
                console.log("esc pressed")
                root.open = false
                event.accepted = true
            }
        }
    }

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
        menu.y = this.height - 5
        searchBar.inputText.text = ""
    }

    Rectangle {
        id: menu
        Behavior on y {
            NumberAnimation {duration: 200}
        }
        width: root.searchWidth
        height: root.searchHeight
        topRightRadius: 20
        topLeftRadius: 20
        color: "#8f282a36"

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
        SearchBar{id: searchBar}
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
            color: "transparent"
            width: parent.width * 0.9
            height: parent.height * 0.83

            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            Flickable {
                anchors.fill: parent
                contentWidth: width
                contentHeight: columnLayout.height
                clip: true
                ColumnLayout {
                    id: columnLayout
                    spacing:  10
                    anchors {
                        top: parent.top
                        topMargin: 10
                        horizontalCenter: parent.horizontalCenter
                    }
                    Repeater{
                        model: {
                            DesktopEntries.applications.values.filter(app =>{
                                if(searchBar.inputText.text.length ===  0){
                                    return true
                                }else{

                                    return app.name.toLowerCase().includes(searchBar.inputText.text.toLocaleLowerCase())
                                }
                            })
                        }
                        //model: 10
                        ApplicationBox{}
                    }
                }
            }
        }
    }
}
