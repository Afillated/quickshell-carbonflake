import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

import qs.services
import qs.components
import qs.widgets

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: notiPopups
            required property var modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Overlay
            // visible: false
            anchors {
                bottom: true
                left: true
            }
            margins {
                left: 10
                bottom: 51
            }
            implicitHeight: modelData.height / 2
            implicitWidth: 400
            color: "transparent"
            exclusionMode: ExclusionMode.Ignore
            mask: Region {
                item: notiView
            }
            ListView {
                id: notiView
                model: NotiServer.items
                width: height > 0 ? notiPopups.modelData.height/2: 0.1
                height: contentHeight
                clip: true
                interactive: false
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                }
                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutQuad
                    }
                }
                verticalLayoutDirection: ListView.BottomToTop

                delegate: Item {
                    id: delegateRoot
                    width: 400
                    height: contentWrapper.height + 10
                    clip: true

                    required property var model
                    readonly property bool isDismissed: model.notiItem ? model.notiItem.dismissed : false

                    Item {
                        id: contentWrapper
                        width: parent.width
                        height: inCard.implicitHeight
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.bottomMargin: 10

                        NotiCard {
                            id: inCard
                            noti: delegateRoot.model.notiItem
                            color: "black"
                            onClicked: {
                                delegateRoot.state = "dismissed";
                            }
                        }
                    }

                    states: [
                        State {
                            name: "dismissed"
                            when: delegateRoot.isDismissed
                            PropertyChanges {
                                delegateRoot.visible: false
                                delegateRoot.enabled: false
                                delegateRoot.height: 0
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            to: "dismissed"
                            SequentialAnimation {
                                ParallelAnimation {
                                    NumberAnimation {
                                        target: contentWrapper
                                        property: "x"
                                        to: -delegateRoot.width
                                        duration: 300
                                        easing.type: Easing.OutCubic
                                    }
                                    NumberAnimation {
                                        target: contentWrapper
                                        property: "opacity"
                                        to: 0
                                        duration: 300
                                    }
                                }

                                NumberAnimation {
                                    target: delegateRoot
                                    property: "height"
                                    to: 0
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }

                                PropertyAction {
                                    target: delegateRoot
                                    property: "visible"
                                    value: false
                                }
                            }
                        }
                    ]
                }

                add: Transition {
                    NumberAnimation {
                        properties: "x"
                        from: -400
                        duration: 300
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        properties: "opacity"
                        from: 0
                        to: 1
                        duration: 300
                    }
                }
                displaced: Transition {
                    NumberAnimation {
                        properties: "y"
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
}
