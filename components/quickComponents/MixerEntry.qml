import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.theme
import qs.components

ClippingRectangle {
    id: entry
    required property PwNode node
    property int fontSize
    color: "transparent"
    PwObjectTracker {
        objects: [entry.node]
    }

    implicitHeight: content.implicitHeight
    function getIcon() {
        if (DesktopEntries.byId(entry.node?.name))
            return Quickshell.iconPath(DesktopEntries.byId(entry.node?.name).icon);
        return 'image://icon/audio-volume-high-symbolic';
    }

    ColumnLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        RowLayout {
            Layout.fillWidth: true
            Image {
                id: entryImage
                sourceSize: Qt.size(entry.fontSize * 0.8, entry.fontSize * 0.8)
                source: entry.getIcon(entry.node?.name)
                Layout.leftMargin: entry.fontSize / 2
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                id: name
                Layout.maximumWidth: content.width * 0.8
                elide: Text.ElideRight
                Layout.alignment: Qt.AlignVCenter
                text: entry.node?.properties["application.name"] ? entry.node?.properties["application.name"] : entry.node?.description
                color: Colors.foreground
                font {
                    pixelSize: entry.fontSize * 1.2
                }
            }
        }
        Slider {
            id: volSlider
            Layout.fillWidth: true
            value: entry.node?.audio.volume
            from: 0
            to: 1.52
            stepSize: 0.01
            live: true
            implicitHeight: entry.fontSize * 2
            background: ClippingRectangle {
                radius: height / 3
                color: "#55967373"
                clip: true
                Rectangle {
                    width: volSlider.visualPosition * parent.width
                    height: parent.height
                    radius: height / 3
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop {
                            position: 0.0
                            color: Colors.color13
                        }
                        GradientStop {
                            position: 1.0
                            color: Colors.color10
                        }
                    }
                    Text {
                        visible: volSlider.pressed
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: entry.fontSize
                        }
                        color: Colors.background
                        text: Math.trunc(entry.node?.audio.volume * 100)
                        font.pixelSize: entry.fontSize
                    }
                }
            }
            handle: Rectangle {
                x: volSlider.visualPosition * (volSlider.availableWidth - width)
                height: parent.height
                width: height
                radius: height / 3
                color: "transparent"
            }
            onMoved: {
                entry.node.audio.volume = value;
            }
        }
    }
}
