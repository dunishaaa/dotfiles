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
    function getNfrequencies(n, mode = "rms") {
        const result = [];

        for (let i = 0; i < n; i++) {
            const start = Math.floor(i * frequencies.length / n);

            const end = Math.floor((i + 1) * frequencies.length / n);

            let max = 0;
            let sum = 0;
            let sumSquares = 0;
            let count = 0;

            for (let j = start; j < end; j++) {
                const value = frequencies[j];

                max = Math.max(max, value);
                sum += value;
                sumSquares += value * value;
                count++;
            }

            if (mode === "max") {
                result.push(max);
            } else if (mode === "average") {
                result.push(sum / count);
            } else {
                result.push(Math.sqrt(sumSquares / count));
            }
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
