pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Effects

//DropdownBox.qml
Item {
    id: root
    property string backgroundColor: "#80282a36"
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

        bottomLeftRadius: 16
        bottomRightRadius: 16
        color: root.backgroundColor
    }
}
