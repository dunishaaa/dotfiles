import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io


PanelWindow{
    id: root
    visible: SessionState.open
    property int mar: 500
    implicitHeight: 200
    color: "transparent"
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
        color: "#8f282a36"
    }
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
        command: ["sh", "-c", "shutdown now"]
    }
    Process {
        id: suspendProc
        running: false
        //command: ["sh", "-c", "systemctl suspend && hyprlock"]
        command: ["notify-send", "a mimir"]
    }
    Process {
        id: logoutProc
        running: false
        //command: ["sh", "-c", "hyprshutdown"]
        command: ["notify-send", "no sirvo"]
    }

}
