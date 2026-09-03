pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

import "../services/"

//AudioFrequencies.qml
RowLayout {
    id: root

    required property int boxHeight
    required property int numberOfBars
    required property int barHeight
    required property int barWidth

    required property int minBarHeight
    required property int maxBarHeight
    required property int barRadius
    property var qtAlignment: Qt.AlignVCenter
    property bool open: false
    property string barColor: "#c3c1ee"
    visible: false

    property var frequencies: CavaService.getNfrequencies(numberOfBars)

    Loader {
        active: Mpris.players.values.length > 0

        sourceComponent: MprisService {
            id: mpris
            player.onPlaybackStateChanged: {
                root.open = mpris.player.playbackState === MprisPlaybackState.Playing;
            }
        }
    }

    Layout.preferredHeight: root.boxHeight

    Repeater {

        model: root.frequencies.length

        Rectangle {
            required property int index

            color: root.barColor
            radius: root.barRadius

            Layout.preferredWidth: root.barWidth //* CavaService.widths[index]

            Layout.preferredHeight: {
                const frequency = root.frequencies[index] ?? 0;

                const freqSize = (root.boxHeight * 0.83) * (frequency / 100);

                return CavaService.clamp(freqSize, root.minBarHeight, root.maxBarHeight);
            }
        }
    }
}
