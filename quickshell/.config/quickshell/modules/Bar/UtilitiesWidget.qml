import Quickshell
import QtQuick
import "../../services"

BarBox{
    id: root
    property int utilitiesWidth: textIcon.width + cpuIcon.width
    NetworkService{id: networkService}
    Item {
        anchors.fill: parent
        Text {
            id: textIcon
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 15
            }
            color: "white"
            text: {
                //console.log("Connection from widget: " + networkService.connected)
                if(networkService.connected){
                    return "󰈀"
                }else{
                    return "󰈂";
                }
            }
        }
        CpuService{id: cpuService}
        Text {
            id: cpuIcon
            anchors {
                verticalCenter: parent.verticalCenter
                right: textIcon.right
                rightMargin: 15
            }
            color: "white"
            text: `: ${Math.round(cpuService.cpuUsage * 100)}%`
            font{
                pixelSize: 10
                family: "Ticketing"
            }
        }
    }

}
