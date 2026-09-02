pragma ComponentBehavior: Bound
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

//AudioController.qml
Rectangle {
    id: root
    required property real controllerWidth
    required property real controllerHeight
    required property string backgroundColor
    required property PwNode audioSource
    required property string unMutedIcon
    required property string mutedIcon
    required property string iconColor
    required property int iconPixelSize

    color: backgroundColor
    Layout.preferredWidth: controllerWidth
    Layout.preferredHeight: controllerHeight
    radius: 15

    Text {
        anchors {
            top: parent.top
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        text: !root.audioSource.audio.muted ? root.unMutedIcon : root.mutedIcon
        color: root.iconColor
        font {
            pixelSize: root.iconPixelSize
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.audioSource.audio.muted = !root.audioSource.audio.muted;
            }
        }
    }
    Slider {
        id: slider
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 12
        }
        handle: Rectangle {
            id: handleRect
            implicitWidth: 22
            implicitHeight: implicitWidth
            radius: implicitWidth
            x: slider.leftPadding + (slider.availableWidth - width)
            y: slider.height * slider.value - implicitWidth
            color: slider.pressed ? "#565390" : "#9d99e3"
        }
        background: Rectangle {
            implicitWidth: handleRect.implicitWidth
            implicitHeight: slider.height
            radius: 20
            color: "#525263"
            Rectangle {
                implicitWidth: parent.implicitWidth
                implicitHeight: slider.height * slider.value
                radius: 20
                color: "#c3c1ee"
            }
        }

        height: parent.height * 0.75
        from: 1
        to: 0
        value: root.audioSource.audio.volume
        orientation: Qt.Vertical
        onMoved: {
            root.audioSource.audio.volume = slider.value;
        }
    }
    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing: Easing.InQuad
        }
    }
    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            root.scale = hovered ? 1.04 : 1;
        }
    }
}
