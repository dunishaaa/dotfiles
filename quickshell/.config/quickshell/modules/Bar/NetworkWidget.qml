import Quickshell
import QtQuick
import "../../services"

BarBox{
    id: root
    property int iconWidth: textIcon.width
    NetworkService{id: networkService}
    Text {
        id: textIcon
        anchors.centerIn: parent
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

}
