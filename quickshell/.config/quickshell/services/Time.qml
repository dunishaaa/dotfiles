pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    function giveTimeFormat(format: string): string{
        if(format == "full"){
            return Qt.formatDateTime(clock.date, "HH:mm MMM dd, ddd yyyy")
        }else if(format == "time"){
            return Qt.formatDateTime(clock.date, "HH:mm")
        }
    }

    readonly property string time: {
        //Qt.formatDateTime(clock.date, "dd dddd MMM  HH:mm ")
        Qt.formatDateTime(clock.date, "HH:mm MMM dd, ddd yyyy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

}
