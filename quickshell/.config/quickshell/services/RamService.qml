import Quickshell.Io
import Quickshell
import QtQuick

Scope{
    id: root
    property real memTotal: 0
    property real memFree: 0
    property real memAvailable: 0
    FileView{
        id: ramFile
        path: "/proc/meminfo"
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.updateRamUsage()
    }

    function updateRamUsage(){
        ramFile.reload()
        const text = ramFile.text()
        const memInfo = text.split("\n")
        root.memTotal = Number(memInfo[0].match(/\d+/g))
        root.memFree = Number(memInfo[1].match(/\d+/g))
        root.memAvailable = Number(memInfo[2].match(/\d+/g))
    }


}
