import QtQuick
import QtQuick.Layouts
import "../../../services"
import "../AudioFrequencies"
import "../../../components"

//CentralWidget.qml
BarBox {
    id: root
    //    property bool hovered: hoverHandler.hovered
    boxWidth: items.width + 40

    property string timeFormat: "time"

    RowLayout {
        id: items
        anchors.centerIn: root
        spacing: 8
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
            numberOfBars: 14
            barHeight: root.height
            barWidth: 3
            minBarHeight: root.height * 0.2
            maxBarHeight: root.height * 0.94
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
