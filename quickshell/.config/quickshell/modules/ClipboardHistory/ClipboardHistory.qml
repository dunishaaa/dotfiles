pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick

import "../../components"

//ClipboardHistory.qml
FloatingWindow {
  id: root
  title: "Clipboard history"
  maximized: false
  fullscreen: false
  maximumSize: Qt.size(300, 400)
  property bool open: false
  visible: open
  implicitWidth: 300
  implicitHeight: 500
  color: "transparent"
  Rectangle {
    anchors.fill: parent
    color:"#b0784a86"

    ListModel {
      id: historyModel
    }
    ListView {
      id: list
      anchors.fill: parent
      anchors.topMargin: 20
      model: historyModel
      spacing: 3 

      delegate: StyledBox {
        id: delgateRoot
        required property string contents 
        required property string id
        width: root.implicitWidth * 0.87
        height: root.implicitHeight / 10
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
          text: delgateRoot.contents
          anchors{

            left: parent.left
            top: parent.top
            topMargin: 10
            leftMargin: 15


          }

          color: "white"
        }
        mouseArea.onClicked: {
          console.log(id)
          root.copyToClipboard(id);

        }
      }
    }
    

    IpcHandler {
      target: "clipboardHist"
      function toggle(): void {
        if(!root.open){

          historyModel.clear();
          historyList.running = true;
        }else[
          root.open = false
        ]
      }
    }
    Process {
      id: historyList
      command: ["cliphist", "list"]
      running: false
      stdout: SplitParser {
        onRead: data => {
          let match = data.match(/^(\d+)\s+(.+)$/)
          if(match){
            console.log("match: " + match[1])
            let id = match[1]
            let contents = match[2]
            historyModel.append({id: id, contents: contents})
          }
        }
      }
      onExited: (exitCode, exitStatus) => {
        root.open = true
      }
    }

    Process {
      id: decodeEntry
      command: ["cliphist", "decode"]
      running: false
      //TODO: leer stdout y copiarlo al cp history
      onExited: (exitCode, exitStatus) => {
        root.open = false

      }

    }
  }
  function copyToClipboard(id){
    decodeEntry.command = ["sh", "-c", `cliphist decode ${id} | wl-copy && notify-send copied ${id}`]
    decodeEntry.running = true

  }
}
