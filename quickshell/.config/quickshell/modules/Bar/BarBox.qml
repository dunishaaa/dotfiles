pragma ComponentBehavior: Bound
import QtQuick // for Text


//BarBox.qml
Rectangle {
    id: root
    required property int boxHeight

    height: boxHeight

    Behavior on width{
        NumberAnimation {
            duration: 200
            easing.overshoot: 20
            easing.type: Easing.OutCubic
        }
    }
    Behavior on scale {
        NumberAnimation {duration: 100}
    }

    HoverHandler{
        id: hoverHandler
        onHoveredChanged: {
            root.scale = hovered ? 1.05 : 1
            root.color = hovered ? "#f0292b37" : "#80282a36"
        }
    }

    bottomLeftRadius: 16
    bottomRightRadius: 16
    color: "#80282a36"

}
