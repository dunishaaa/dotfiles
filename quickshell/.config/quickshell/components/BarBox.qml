pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Effects

//BarBox.qml
Item {
    id: root
    required property int boxHeight
    required property int boxWidth

    property real collapsedWidth: boxWidth
    property real exandedWidth: boxWidth

    property string backgroundColor: "#80282a36"

    property bool enableHover: true
    property bool enablePopup: false

    property bool expanded: false

    property Popup popup

    property real currentWidth: collapsedWidth

    height: boxHeight
    width: boxWidth

    function openPopup() {
        if (!enablePopup || !popup)
            return;
        if (expanded)
            return;
        expanded = true;
        expandAnim.start();
    }

    function closePopup() {
        if (!popup)
            return;
        if (!expanded)
            return;
        popup.open = false;
    }
    function togglePopup() {
        if (!popup)
            return;
        if (popup.open)
            closePopup();
        else
            openPopup();
    }

    Rectangle {
        id: sourceBox

        width: parent.width
        height: parent.height

        bottomLeftRadius: 16
        bottomRightRadius: 16
        color: root.backgroundColor

        Behavior on scale {
            NumberAnimation {
                duration: 100
            }
        }

        HoverHandler {
            enabled: root.enableHover
            onHoveredChanged: {
                sourceBox.scale = hovered ? 1.05 : 1;
                sourceBox.color = hovered ? "#f0292b37" : "#80282a36";
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.togglePopup();
        }
    }
    NumberAnimation {
        id: expandAnim
        target: root
        property: "currentWidth"

        from: root.collapsedWidth + 30
        to: root.exandedWidth

        duration: 100

        easing.type: Easing.InOutQuad

        onFinished: {
            root.popup.open = true;
        }
    }
    NumberAnimation {
        id: shrinkAnim
        target: root
        property: "currentWidth"

        from: root.exandedWidth
        to: root.collapsedWidth

        duration: 100

        easing.type: Easing.InOutQuad

        onFinished: {
            root.expanded = false;
        }
    }

    Connections {
        target: root.popup
        function onHidden() {
            shrinkAnim.start();
        }
    }
}
