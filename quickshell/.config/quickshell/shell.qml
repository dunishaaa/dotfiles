pragma ComponentBehavior: Bound

import Quickshell
import QtQuick // for Text
import QtQuick.Layouts // for Text
import Quickshell.Services.Pipewire
import QtQuick.Shapes
import Quickshell.Services.Mpris

import "modules/Bar"
import "modules/SessionMenu"
import "modules/VolumeStatusBar"
import "modules/MediaPlayer"
import "modules/SearchMenu"
import "modules/NotificationPanel"
import "services"
import "components"

//shell.qml
Scope {

    NotificationService {
        id: notificationService
    }

    Bar {
        id: bar
    }
    SessionMenu {}
    Loader {
        active: Pipewire.ready
        sourceComponent: VolumeStatusBar {}
    }
    SearchMenu {
        id: searchMenu
    }

    //    SearchMenuDetection{
    //       searchMenu: searchMenu
    //  }
    NotificationPanel {
        notificationService: notificationService
    }
    TemporalNotificationsPanel {
        notificationService: notificationService
    }

    Wallpaper {}
    NetworkService {}
    /*
   PanelWindow {
     visible: false
     width: 300
     height: 150
     Shape {
       width: 200
       height: 150
       ShapePath {
         strokeWidth: 10
         strokeColor: "blue"
         fillColor: "red"
         PathLine{ x: 0; y: 0}
         PathLine{ x: 100; y: 100}
         PathLine{ x: 200; y: 100}
         PathLine{ x: 0; y: 0}
       }

     }
   }
   */

    PanelWindow {
        id: x
        color: "transparent"
        visible: false
        implicitWidth: 400
        implicitHeight: 250
        MediaPlayer {}
    }
}
