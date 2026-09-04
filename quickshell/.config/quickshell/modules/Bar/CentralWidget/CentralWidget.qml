pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import "../../../services"
import "../AudioFrequencies"
import "../../../components"
import "../../MediaPlayer"

//CentralWidget.qml
BarBox {
    id: root
    boxWidth: items.width + 40
    enableHover: false

    enablePopup: true
    extendedWidth: popup.width

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
    popup: Popup {
        id: popup
        itemToAttach: root
        popup: dropdownMenu
        implicitWidth: dropdownMenu.width
        implicitHeight: dropdownMenu.height
        DropdownBox {
            id: dropdownMenu
            width: 700
            height: 400
            y: 0
            visible: false
            property var frequencies: CavaService.getNfrequencies(62, "avarage")
            RowLayout {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.centerIn: parent
                spacing: 2
                Repeater {
                    model: dropdownMenu.frequencies.length
                    Rectangle {
                        required property int index
                        width: 8
                        height: CavaService.clamp(dropdownMenu.height * 0.92 * dropdownMenu.frequencies[index] / 100, 10, dropdownMenu.height * 0.92)
                        color: "#44c3c1ee"
                        bottomLeftRadius: 2
                        bottomRightRadius: 2
                        Layout.alignment: Qt.AlignBottom
                    }
                }
            }
            MediaPlayer {}
        }
    }
}
