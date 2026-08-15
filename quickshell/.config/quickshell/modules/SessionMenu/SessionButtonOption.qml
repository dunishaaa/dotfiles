 import Quickshell
 import QtQuick
 import Quickshell.Io
 Rectangle {
     id: root
     width: 200
     height: 150
     color: "black"
     radius: 20
     required property string symbol
     required property Process process
     property bool hovered: false
     Behavior on scale {
         NumberAnimation {duration: 100}
     }
     scale: hovered ? 1.2: 1
     Text {
         anchors {
             verticalCenter: parent.verticalCenter
             horizontalCenter: parent.horizontalCenter
         }
         text: root.symbol
         color: "white"
         font {
             family: "Ticketing"
             pixelSize: 50
         }
     }
     MouseArea {
         anchors.fill: parent
         hoverEnabled: true
         onClicked: {
             root.process.running = true
             SessionState.open = false
         }
         onEntered: root.hovered = true
         onExited: root.hovered = false

     }
 }
