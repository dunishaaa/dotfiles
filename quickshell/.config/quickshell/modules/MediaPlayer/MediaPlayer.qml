pragma ComponentBehavior: Bound

import Quickshell
import QtQuick // for Text
import QtQuick.Layouts // for Text
import Quickshell.Services.Mpris

import "../../services"

Item {
    id: yo
    MprisService {
        id: mpris
    }
    property int mariginSpacing: 40
    anchors.fill: parent
    //color: "#80c3c1ee"
    //radius: 16
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
            topMargin: yo.height * 0.25
            horizontalCenter: parent.horizontalCenter
        }
        Image {
            anchors.centerIn: parent
            source: "file:////home/dunishaaa/Pictures/AMGI0458_01.jpg"
            sourceSize.width: 4 * 50
        }
    }
    Item {
        id: controls
        width: parent.width * 0.5
        height: 30
        anchors {
            top: yo.top
            topMargin: parent.height * 0.6
            horizontalCenter: parent.horizontalCenter
        }
        RowLayout {
            spacing: 20
            anchors.centerIn: parent
            Text {
                text: ""
                font.pixelSize: 30
                color: "#dbc8ed"
            }
            Text {
                id: playIcon
                text: mpris.player.isPlaying ? "" : ""
                font.pixelSize: 40
                color: "#dbc8ed"
                MouseArea {
                    id: mouseArea
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: mpris.player.isPlaying = !mpris.player.isPlaying
                    onEntered: playIcon.color = "white"
                    onExited: playIcon.color = "#dbc8ed"
                }
            }
            Text {
                text: ""
                font.pixelSize: 30
                color: "#dbc8ed"
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
            color: "#c3c1ee"
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
                color: "#565390"
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
            color: "#dbc8ed"
        }
        RowLayout {
            anchors.top: trackTitle.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 5

            Text {
                id: trackArtist
                text: mpris.player.trackArtist + "  -"
                color: "#dbc8ed"
                font.pixelSize: 10
            }

            Text {
                id: trackAlbum
                text: mpris.player.trackAlbum.substring(0, 65)
                color: "#dbc8ed"
                font.pixelSize: 10
            }
        }
    }
}
