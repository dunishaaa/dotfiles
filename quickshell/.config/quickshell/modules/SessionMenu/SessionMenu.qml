import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Wayland


Item {
    PanelWindow{

        id: root
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
                    SessionState.open = false
                    event.accepted = true
                }
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
            //command: ["notify-send", "a mimir"]
        }
        Process {
            id: logoutProc
            running: false
            //command: ["sh", "-c", "hyprshutdown"]
            command: ["hyprctl", "dispatch", "hl.dsp.exit()"]
        }

    }

}
