import Quickshell
import Quickshell.Io
import QtQuick
import QtQml

Scope{
    Process {
        id: randomWallpaperProc
        running: false
        command: ["randomWallpaper.sh"]
    }
    Timer {
        running: true
        repeat: true
        //   convert to miliseconds
        interval:  11 * 62 * 1003
        onTriggered: randomWallpaperProc.running = true

    }


}
