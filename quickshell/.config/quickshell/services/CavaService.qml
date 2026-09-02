pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var frequencies: Array(64).fill(0)
    property var widths: [0.7, 0.7, 0.75, 0.8, 0.9, 1.2, 1.2, 0.9, 0.8, 0.75, 0.7, 0.7]
    Process {
        id: cavaProc
        command: ["cava"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.frequencies = data.split(";").filter(x => x !== "").map(x => Number(x));
            }
        }
    }
    function clamp(value, min, max) {
        return Math.min(Math.max(min, value), max);
    }
    function getNfrequencies(n) {
        let result = Array(n);
        let step = Math.floor(root.frequencies.length / n);
        for (let i = 0, cur = 0; i < root.frequencies.length; i += step, cur++) {
            result[cur] = root.frequencies[i];
        }
        return result;
    }
    function getWidthsOfNfrequencies() {
    }
    function isAudioPlaying() {
        let total = 0;
        for (let freq of root.frequencies) {
            total = +freq;
        }
        return total > 0;
    }
}
