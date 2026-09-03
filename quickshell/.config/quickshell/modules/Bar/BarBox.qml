pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Effects

////BarBox.qml
Item {
    id: root

    required property int boxHeight
    required property int boxWidth
    property string backgroundColor: "#80282a36"
    property bool enableHover: true
    height: boxHeight
    width: boxWidth
    Rectangle {
        id: sourceBox
        width: parent.width
        height: parent.height

        Behavior on width {
            NumberAnimation {
                duration: 100
                easing.overshoot: 10
                easing.type: Easing.Linear
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 100
            }
        }

        HoverHandler {
            id: hoverHandler
            enabled: root.enableHover
            onHoveredChanged: {
                sourceBox.scale = hovered ? 1.05 : 1;
                sourceBox.color = hovered ? "#f0292b37" : "#80282a36";
            }
        }

        bottomLeftRadius: 16
        bottomRightRadius: 16
        color: root.backgroundColor
    }
}
