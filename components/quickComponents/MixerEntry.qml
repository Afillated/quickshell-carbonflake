import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.theme
import qs.components
import qs.services

ClippingRectangle {
    id: entry
    required property PwNode node
    property int fontSize
    color: "transparent"
    PwObjectTracker {
        objects: [entry.node]
    }
    readonly property bool isDefault: (node === Audio.defaultOutput || node === Audio.defaultInput)
    implicitHeight: content.implicitHeight
    function getIcon() {
        if (entry.node.type === PwNodeType.AudioSource) {
            if (entry.node.audio?.muted)
                return "image://icon/microphone-sensitivity-muted-symbolic";
            return "image://icon/audio-input-microphone-symbolic";
        } else {
            if (entry.node.audio?.muted || entry.node.audio?.volume === 0)
                return "image://icon/audio-volume-muted-symbolic";
            if (entry.node.audio?.volume < 0.3)
                return "image://icon/audio-volume-low-symbolic";
            if (entry.node.audio?.volume < 0.7)
                return "image://icon/audio-volume-medium-symbolic";
            return "image://icon/audio-volume-high-symbolic";
        }
    }

    ColumnLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        ClippingRectangle {
            id: nameRec
            implicitWidth: nameRow.width + height / 2
            implicitHeight: nameRow.height + entry.fontSize / 4
            radius: height / 3
            color: area.containsMouse ? "#33AAAAAA" : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea {
                id: area
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (entry.node.isSink) {
                        Audio.setDefaultOutput(entry.node);
                    } else {
                        Audio.setDefaultInput(entry.node);
                    }
                }
            }
            RowLayout {
                id: nameRow
                anchors.centerIn: parent
                Image {
                    id: entryImage
                    sourceSize: Qt.size(entry.fontSize * 0.8, entry.fontSize * 0.8)
                    source: entry.getIcon()
                    Layout.alignment: Qt.AlignVCenter
                }
                Text {
                    id: name
                    Layout.maximumWidth: content.width * 0.8
                    elide: Text.ElideRight
                    Layout.alignment: Qt.AlignVCenter
                    text: entry.node?.description
                    color: area.containsMouse ? Colors.color10 : Colors.foreground
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    font {
                        pixelSize: entry.fontSize * 1.2
                    }
                }
                Text {
                    id: isDefault
                    Layout.alignment: Qt.AlignVCenter
                    text: entry.isDefault ? "" : ""
                    color: entry.isDefault ? Colors.color10 : Colors.foreground
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                    opacity: entry.isDefault ? 1 : 0
                    visible: opacity > 0
                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                    font {
                        pixelSize: entry.fontSize * 1.2
                    }
                }
            }
        }
        Slider {
            id: volSlider
            Layout.fillWidth: true
            value: parseFloat(entry.node?.audio.volume)
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
