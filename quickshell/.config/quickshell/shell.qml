pragma ComponentBehavior: Bound

import Quickshell
import QtQuick // for Text
import Quickshell.Services.Pipewire
import Quickshell.Networking

import "modules/Bar"
import "modules/SessionMenu"
import "modules/VolumeStatusBar"
import "modules/SearchMenu"
import "modules/NotificationPanel"
import "services"
import "components"

//shell.qml
Scope {

    NotificationService{id: notificationService}

    Bar{id: bar}
    SessionMenu{}
    Loader{
        active: Pipewire.ready
        sourceComponent: VolumeStatusBar{}
    }
    SearchMenu{
        id: searchMenu
    }

    //    SearchMenuDetection{
    //       searchMenu: searchMenu
    //  }
    NotificationPanel{
        notificationService: notificationService
    }
    TemporalNotificationsPanel{notificationService: notificationService}

    Wallpaper{}
    NetworkService{}
    /*
    CpuService{id: cpuService}

    PanelWindow{
        implicitHeight: 300
        implicitWidth: 400
        color: "transparent"
        StyledBox{
            height: 150
            width: 300
            anchors.centerIn: parent
            baseColor: "blue"
            Text {
                anchors.centerIn: parent
                color: "white"
                text: Math.round(cpuService.cpuUsage * 100 * 10)/10
            }

        }
    }
    */
}
