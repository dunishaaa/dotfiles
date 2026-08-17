pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Layouts


//SearchMenu
PanelWindow {
    id: root

    property int searchWidth: 600
    property int searchHeight: 400

    focusable: true
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0


    visible: false
    anchors.bottom: true
    color: "transparent"
    implicitWidth: root.searchWidth
    implicitHeight: root.searchHeight

    onVisibleChanged: {
        if(visible){
            searchBar.inputText.forceActiveFocus()
        }
    }

    Rectangle {
        id: menu
        property bool hover: false
        property bool active: false
        Behavior on y {
            NumberAnimation {duration: 200}
        }
        width: root.searchWidth
        height: root.searchHeight
        topRightRadius: 20
        topLeftRadius: 20
        color: "#8f282a36"
        y: active || hover ? 0 : this.height - 5

        //Enter cooldown
        Timer {
            id: enterCooldowntimer
            interval: 200
            running: false
            onTriggered:{
                menu.active = true
            }
        }

        //exit cooldown
        Timer{
            id: exitCooldownTimer
            interval: 700
            running: false
            onTriggered: {
                root.visible = false
                menu.hover = false
            }

        }

        Timer {
            id: lowerSearchbar
            interval: exitCooldownTimer.interval - 100
            running: false
            onTriggered: {
                menu.active = false
                menu.hover = false
            }
        }
        SearchBar{id: searchBar}
        HoverHandler {
            onHoveredChanged: {
                if(hovered){
                    menu.hover = true
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
