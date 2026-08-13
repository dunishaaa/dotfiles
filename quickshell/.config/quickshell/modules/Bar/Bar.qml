
import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts // for Text

import Quickshell.Wayland
import "Clock"
import "Workspaces"



Scope {
  Variants{

    model: Quickshell.screens
    PanelWindow {
      implicitHeight: 35

      color: "transparent"

      required property var modelData
      screen: modelData

      anchors {
        top: true
        right: true
        left: true
      }
      margins {
        right: 10
        left: 10
        top: 5
        bottom: 5
      }
      Rectangle {
        id: bar
        anchors.fill: parent
        radius: 16
        color: "#aa282a36"
        Workspaces{}
        ClockWidget {}
        SessionButton{}

      }
    }
  }

}

