pragma ComponentBehavior: Bound
import QtQuick // for Text


//BarBox.qml
Rectangle {
    id: barBox
    required property int boxHeight

    height: boxHeight

    Behavior on width{
        NumberAnimation {
            duration: 200
            easing.overshoot: 20
            easing.type: Easing.OutCubic
        }
    }
    bottomLeftRadius: 16
    bottomRightRadius: 16
    color: "#7f282a36"
}
