import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Wayland


PanelWindow{
    id: root

    IpcHandler {
        target: "sessionMenu"
        function open(){
            SessionState.open = true
        }
    }

    visible: SessionState.open
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    property int mar: 500
    implicitHeight: 200
    color: "transparent"
    Item {
        id: keyHandler
        anchors.fill: parent
        focus: true
        Keys.onPressed: (event) => {
            if(event.key == Qt.Key_Escape){
                event.accepted = true
            }else if(event.key == Qt.Key_P){
                console.log("power off")
                shutdownProc.running = true
            }else if(event.key == Qt.Key_S){
                console.log("suspend")
                suspendProc.running = true
            }else if(event.key == Qt.Key_L){
                console.log("logout")
                logoutProc.running = true
            }
            event.accepted = true
            SessionState.open = false
        }
    }
    onVisibleChanged: {
        if(visible){
            keyHandler.forceActiveFocus()
        }
    }
    //Hide panel when Esc is pressed

    anchors {
        left: true
        right: true
    }
    margins {
        right: mar
        left: mar
    }
    Rectangle {
        anchors.fill: parent
        radius: 20
        color: "#80282a36"
    }

    // Menu buttons
    RowLayout {
        spacing: 80
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        SessionButtonOption {
            symbol: "⏻"
            process: shutdownProc
        }
        SessionButtonOption {
            symbol: "󰤄"
            process: suspendProc
        }
        SessionButtonOption {
            symbol: "󰩈"
            process: logoutProc
        }
    }
    Process {
        id: shutdownProc
        running: false
        command: ["systemctl", "poweroff"]
    }
    Process {
        id: suspendProc
        running: false
        command: ["sh", "-c", "systemctl suspend && hyprlock"]
    }
    Process {
        id: logoutProc
        running: false
        command: ["hyprctl", "dispatch", "hl.dsp.exit()"]
    }

}
