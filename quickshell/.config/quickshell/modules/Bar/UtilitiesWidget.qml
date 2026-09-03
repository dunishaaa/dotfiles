import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../components"
import "../../services"

BarBox {
    id: root
    property real utilitiesWidth: utilities.width
    NetworkService {
        id: networkService
    }

    RowLayout {
        id: utilities
        anchors {
            centerIn: parent
            leftMargin: 15
            rightMargin: 15
        }
        spacing: 13
        Text {
            id: netIcon

            color: "white"
            text: {
                //console.log("Connection from widget: " + networkService.connected)
                if (networkService.connected) {
                    return "󰈀";
                } else {
                    return "󰈂";
                }
            }
        }
        CpuService {
            id: cpuService
        }
        Text {
            id: cpuIcon

            color: "white"
            text: {
                let cpuUsage = String(Math.round(cpuService.cpuUsage * 100));
                if (cpuUsage.length === 1) {
                    //cpuUsage = " " + cpuUsage
                }
                return `  ${cpuUsage}%`;
            }
            font {
                pixelSize: 10
                family: "Ticketing"
            }
        }
        RamService {
            id: ramService
        }
        Text {
            id: ramIcon

            color: "white"
            text: {
                let total = Math.round(ramService.memTotal / 1000000 * 10) / 10;
                let used = Math.round(10 * (total - Math.round(ramService.memAvailable / 1000000 * 10) / 10)) / 10;
                return `  ${used}GB/${total}GB`;
            }
            font {
                pixelSize: 10
                family: "Ticketing"
            }
        }
    }
}
