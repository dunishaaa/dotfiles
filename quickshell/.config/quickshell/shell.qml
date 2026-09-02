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
    MprisService {
        id: mpris
    }
    PanelWindow {
        id: x
        visible: false
        color: "transparent"
        implicitWidth: 400
        implicitHeight: 250
        Rectangle {
            id: yo
            property int mariginSpacing: 40
            anchors.fill: parent
            color: "#80c3c1ee"
            radius: 16
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Mpris players: " + Mpris.players.values.length);
                    Mpris.players.values.map(entry => {
                        console.log("--------------------------------------------------");
                        console.log("track artist: " + entry.trackArtist);
                        console.log(entry.canPause);
                        console.log(entry.isPlaying);
                        console.log(entry.shuffle);
                        console.log("desktop entry: " + entry.desktopEntry);
                        console.log("album: " + entry.trackAlbum);
                        console.log("album artist: " + entry.trackAlbumArtist);
                        console.log("position: " + entry.position);
                        console.log("track title: " + entry.trackTitle);
                        console.log("volume: " + entry.volume);
                        console.log("--------------------------------------------------");
                    });
                }
            }
            Item {
                id: icon
                width: 50
                height: width
                anchors {
                    top: parent.top
                    topMargin: yo.mariginSpacing
                    horizontalCenter: parent.horizontalCenter
                }
            }
            Item {
                id: controls
                width: parent.width * 0.5
                height: 30
                anchors {
                    top: icon.bottom
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                RowLayout {
                    spacing: 20
                    anchors.centerIn: parent
                    Text {
                        text: ""
                        font.pixelSize: 30
                    }
                    Text {
                        text: ""//
                        font.pixelSize: 40
                    }
                    Text {
                        text: ""
                        font.pixelSize: 30
                    }
                }
            }

            Item {
                id: progress
                width: parent.width * 0.85
                height: 6
                anchors {
                    top: controls.bottom
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                Rectangle {
                    id: entireBar
                    anchors.fill: parent
                    radius: 5
                }
                Rectangle {
                    id: progressBar
                    height: progress.height
                    anchors.left: entireBar.left
                    radius: 5
                    color: "red"
                    width: {
                        let duration = mpris.player.length;
                        let current = mpris.player.position;
                        return (entireBar.width) * (current / duration);
                    }
                    FrameAnimation {
                        running: mpris.player.playbackState == MprisPlaybackState.Playing
                        onTriggered: mpris.player.positionChanged()
                    }
                    Rectangle {//TODO: hacerlo gotita
                        id: dot
                        width: 12
                        height: width
                        radius: width
                        color: "blue"
                        y: progressBar.y - Math.abs(progressBar.height - height) / 2
                        x: progressBar.width - (width / 2)
                    }
                }
            }

            Item {
                id: trackInfo
                width: parent.width * 0.5
                height: 50
                anchors {
                    bottom: yo.bottom
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: trackTitle
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: mpris.player.trackTitle
                    color: "black"
                }
                RowLayout {
                    anchors.top: trackTitle.bottom
                    anchors.topMargin: 3
                    anchors.horizontalCenter: parent.horizontalCenter

                    spacing: 5

                    Text {
                        id: trackArtist
                        text: mpris.player.trackArtist + "  -"
                        color: "black"
                        font.pixelSize: 10
                    }

                    Text {
                        id: trackAlbum
                        text: mpris.player.trackAlbum.substring(0, 65)
                        color: "black"
                        font.pixelSize: 10
                    }
                }
            }
            AudioFrequencies {
                id: audioFreq
                anchors.bottom: yo.bottom
                anchors.horizontalCenter: yo.horizontalCenter
                boxHeight: yo.height
                numberOfBars: 12
                barHeight: yo.height * 0.8
                barWidth: 10
                barColor: "red"
                spacing: 10

                minBarHeight: 10
                maxBarHeight: barHeight
                barRadius: 10
            }
        }
    }
}
