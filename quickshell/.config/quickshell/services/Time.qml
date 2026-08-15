pragma Singleton
import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string time: {
    //Qt.formatDateTime(clock.date, "dd dddd MMM  HH:mm ")
    Qt.formatDateTime(clock.date, "HH\nmm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

}
