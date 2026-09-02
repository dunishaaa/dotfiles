pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import "../../../services"

RowLayout {
    id: root

    required property int boxHeight
    required property int numberOfBars
    required property int barHeight
    required property int barWidth

    required property int minBarheight
    required property int maxBarHeight
    required property int barRadius
    property bool open: true

    visible: true

    Layout.preferredHeight: root.boxHeight

    Layout.alignment: Qt.AlignVCenter
    onOpenChanged: {
        if (CavaService.isAudioPlaying()) {
            root.visible = true;
            fadeAnimation.stop();
            fadeAnimation.from = 0;
            fadeAnimation.to = 1;
            fadeAnimation.start();
        } else {
            fadeAnimation.stop();
            fadeAnimation.from = 1;
            fadeAnimation.to = 0;
            fadeAnimation.start();
            //root.visible = false;
        }
    }
    Timer {
        id: checkSound
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            root.open = CavaService.isAudioPlaying();
        }
    }

    NumberAnimation {
        id: fadeAnimation
        target: root
        property: "opacity"
        duration: 200
        onFinished: {
            if (!root.open) {
                root.visible = false;
            }
        }
    }

    Repeater {

        model: root.numberOfBars

        Rectangle {
            required property int index

            color: "#c3c1ee"
            radius: root.barRadius

            Layout.preferredWidth: root.barWidth * CavaService.widths[index]

            Layout.preferredHeight: {
                const frequency = CavaService.frequencies[index] ?? 0;

                const freqSize = (root.boxHeight * 0.83) * (frequency / 100);

                return CavaService.clamp(freqSize, root.minBarheight, root.maxBarHeight);
            }

            Layout.alignment: Qt.AlignVCenter
        }
    }
}
