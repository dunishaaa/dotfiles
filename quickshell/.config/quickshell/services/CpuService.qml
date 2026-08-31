import Quickshell.Io
import Quickshell
import QtQuick

Scope {
    id: root
    property real cpuUsage: 0
    property real previousTotal: 0
    property real previousIdle: 0

    FileView{
        id: cpuFile
        path: "/proc/stat"
    }
    Timer{
        interval: 2000
        running: true
        repeat: true
        onTriggered: root.updateCpuUsage()
    }
    function updateCpuUsage(){
        cpuFile.reload()

        const text = cpuFile.text()
        const firstLine = text.split("\n")[0]
        const values = firstLine.trim().split(/\s+/)

        const user = Number(values[1])
        const nice = Number(values[2])
        const system = Number(values[3])
        const idle = Number(values[4])
        const iowait = Number(values[5])
        const irq = Number(values[6])
        const softirq = Number(values[7])

        const total = user + nice + system + idle + iowait + irq + softirq

        const idleTotal = idle + iowait

        if(root.previousTotal == 0){
            root.previousTotal = total
            root.previousIdle = idleTotal
            return
        }

        const totalDelta = total - root.previousTotal
        const idleDelta = idleTotal - root.previousIdle
        if(totalDelta > 0 ){
            root.cpuUsage = 1 - (idleDelta / totalDelta)
        }

        root.previousTotal = total
        root.previousIdle = idleTotal

    }
}
