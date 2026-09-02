pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Effects

////BarBox.qml
Item {
    id: root
    width: 200

    height: boxHeight
    required property int boxHeight
    Rectangle {
        id: sourceBox
        anchors.fill: parent

        Behavior on width {
            NumberAnimation {
                duration: 400
                easing.overshoot: 10
                easing.type: Easing.OutCubic
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 100
            }
        }

        HoverHandler {
            id: hoverHandler
            onHoveredChanged: {
                sourceBox.scale = hovered ? 1.15 : 1;
                sourceBox.color = hovered ? "#f0292b37" : "#80282a36";
            }
        }

        bottomLeftRadius: 16
        bottomRightRadius: 16
        color: "#80282a36"
    }
    MultiEffect {
        source: sourceBox
        anchors.fill: sourceBox
        blurEnabled: true
        blur: 1.0
        blurMultiplier: 10
        brightness: 0.5
        autoPaddingEnabled: true
    }
}
