import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "../../../services"
import "../"
import "../AudioFrequencies"

//ClockWidget.qml
BarBox {
    id: root
    boxHeight: parent.height
    //    property bool hovered: hoverHandler.hovered
    width: items.width + 40

    property string timeFormat: "time"

    anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }

    RowLayout {
        id: items
        anchors.centerIn: root
        spacing: 10
        Text {
            id: fullTimeText
            visible: false

            text: Time.giveTimeFormat("full")

            color: "#dddddd"//Dracula.selection
            font.family: "Ticketing"
            font.pixelSize: timeText.font.pixelSize + 3
            NumberAnimation {
                id: fullAnim
                target: fullTimeText
                property: "opacity"
                duration: 200
                easing: Easing.Linear
                onFinished: {
                    if (root.timeFormat === "time") {
                        fullTimeText.visible = false;
                        timeText.visible = true;
                    }
                }
            }
        }

        Text {
            id: timeText

            text: Time.giveTimeFormat("time")

            color: "#dddddd"//Dracula.selection
            font.family: "Ticketing"
            font.pixelSize: 14

            NumberAnimation {
                id: timeAnim
                target: timeText
                property: "opacity"
                duration: 200
                easing: Easing.Linear
                onFinished: {
                    if (root.timeFormat === "full") {
                        timeText.visible = false;
                        fullTimeText.visible = true;
                    }
                }
            }
        }

        FrequenciesWidget {
            id: audioFreq
            boxHeight: 28
            numberOfBars: 12
            barHeight: root.height
            barWidth: 4
            minBarHeight: root.height * 0.2
            maxBarHeight: root.height * 0.9
            spacing: 2
            barRadius: 20
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.timeFormat == "full") {
                //activate time
                root.timeFormat = "time";
                timeAnim.from = 0;
                timeAnim.to = 1;
                fullAnim.from = 1;
                fullAnim.to = 0;
                fullAnim.start();
                timeAnim.start();
            } else {
                //activate full
                root.timeFormat = "full";
                fullAnim.from = 0;
                fullAnim.to = 1;
                timeAnim.from = 1;
                timeAnim.to = 0;
                timeAnim.start();
                fullAnim.start();
            }
        }
    }
}
