pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Effects

//BarBox.qml
Item {
    id: root
    required property int boxHeight
    required property int boxWidth

    property real collapsedWidth: boxWidth
    property real extendedWidth: boxWidth

    property string backgroundColor: "#80282a36"

    property bool enableHover: true
    property bool enablePopup: false

    property bool expanded: false

    property Popup popup

    property real currentWidth: collapsedWidth

    height: boxHeight
    width: currentWidth

    function openPopup() {
        if (expanded)
            return;

        expanded = true;
        console.log("Opening popup...");
        expandAnim.start();
    }

    function closePopup() {
        if (!popup)
            return;
        if (!expanded)
            return;
        console.log("Closing popup...");
        popup.open = false;
    }
    function togglePopup() {
        console.log("Toggle popup...");
        if (!popup)
            return;
        if (popup.open)
            closePopup();
        else
            openPopup();
    }

    Rectangle {
        id: sourceBox

        width: root.width
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
            console.log("Clicked");
            root.togglePopup();
        }
    }
    NumberAnimation {
        id: expandAnim
        target: root
        property: "currentWidth"

        from: root.collapsedWidth + 30
        to: root.extendedWidth

        duration: 100

        easing.type: Easing.InOutQuad
        onStarted: {
            console.log("expanding");
        }
        onFinished: {
            console.log("expanded");
            root.popup.open = true;
        }
    }
    NumberAnimation {
        id: shrinkAnim
        target: root
        property: "currentWidth"

        from: root.extendedWidth
        to: root.collapsedWidth

        duration: 100

        easing.type: Easing.InOutQuad

        onFinished: {
            console.log("colapsed");
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
