import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: entry
    required property PwNode node
    color: "transparent"
    radius: 10
    implicitHeight: 70
    PwObjectTracker {
        objects: [entry.node]
    }

    function getIcon() {
        if (DesktopEntries.byId(entry.node.name))
            return Quickshell.iconPath(DesktopEntries.byId(entry.node.name).icon);
        return 'image://icon/audio-volume-high-symbolic';
    }

    Rectangle {
        id: entryInfo
        color: "transparent"
        anchors {
            top: parent.top
            bottom: slider.top
            right: parent.right
            left: parent.left
            margins: 10
        }
        Image {
            id: entryImage
            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            sourceSize: Qt.size(20, 20)
            source: entry.getIcon(entry.node.name)
        }
        RowLayout {
            anchors {
                left: entryImage.left
                leftMargin: 30
                verticalCenter: parent.verticalCenter
            }
            Text {
                id: name
                Layout.maximumWidth: 300
                elide: Text.ElideRight
                text: entry.node.properties["application.name"] ? entry.node.properties["application.name"] : entry.node.description
                color: "#967373"
                font {
                    family: "Comfortaa"
                    pixelSize: 16
                }
            }
        }
    }
    Slider {
        id: slider
        value: entry.node.audio.volume
        from: 0
        to: 1
        stepSize: 0.01
        live: true
        anchors {
            right: parent.right
            left: parent.left
            bottom: parent.bottom
            margins: 10
        }
        implicitWidth: 30
        background: ClippingRectangle {
            implicitHeight: 30
            radius: 30
            color: "#55967373"
            clip: true

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                radius: 20
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop {
                        position: 0.0
                        color: "#550000"
                    }
                    GradientStop {
                        position: 1.0
                        color: "#AA0000"
                    }
                }
                Text {
                    visible: slider.pressed
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 30
                    }
                    color: "black"
                    text: Math.trunc(entry.node?.audio.volume * 100)
                }
            }
        }
        handle: Rectangle {
            x: slider.visualPosition * (slider.availableWidth - width)
            height: 20
            width: 20
            radius: 20
            color: "transparent"
        }
        onMoved: {
            entry.node.audio.volume = value;
        }
    }
}
