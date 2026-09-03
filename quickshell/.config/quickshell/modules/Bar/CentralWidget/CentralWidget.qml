import QtQuick
import QtQuick.Layouts
import "../../../services"
import "../AudioFrequencies"
import "../../../components"

//CentralWidget.qml
BarBox {
    id: root
    boxWidth: items.width + 40
    enableHover: false

    RowLayout {
        id: items
        anchors.centerIn: root
        spacing: 8
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
            numberOfBars: 14
            barHeight: root.height
            barWidth: 3
            minBarHeight: root.height * 0.2
            maxBarHeight: root.height * 0.94
            spacing: 2
            barRadius: 20
        }
    }
}
