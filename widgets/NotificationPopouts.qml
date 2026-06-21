pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.components.notiComponents
import qs.widgets

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: notiPopups
            required property var modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "notifications"
            anchors {
                bottom: true
                left: true
            }
            margins {
                left: 10
                bottom: notiPopups.screen?.height / 20
            }
            implicitHeight: screen?.height / 2
            implicitWidth: screen?.width / 3.5
            color: "transparent"
            exclusionMode: ExclusionMode.Ignore
            mask: Region {
                item: notiView
            }
            ListView {
                id: notiView
                model: NotiServer.items
                width: height > 0 ? notiPopups.screen?.width / 3.5 : 0.1
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
                    width: parent?.width
                    height: contentWrapper.height + 10
                    clip: true

                    required property var model
                    required property int index
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
                            fontSize: notiPopups.screen?.height * 0.02
                            width: notiPopups.screen?.width / 3.5
                            onClicked: {
                                delegateRoot.state = "dismissed";
                            }
                            onRClicked: {
                                delegateRoot.state = "removed";
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
                        },
                        State {
                            name: "removed"
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
                        },
                        Transition {
                            to: "removed"
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

                                ScriptAction {
                                    script: {
                                        NotiServer.items.remove(index);
                                    }
                                }
                            }
                        }
                    ]
                }

                add: Transition {
                    NumberAnimation {
                        properties: "x"
                        from: -notiPopups.screen?.width / 3.5
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
                remove: Transition {
                    NumberAnimation {
                        properties: "x"
                        to: -notiPopups.screen?.width / 3.5
                        duration: 300
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        properties: "opacity"
                        from: 1
                        to: 0
                        duration: 300
                    }
                }
                displaced: Transition {
                    NumberAnimation {
                        properties: "y"
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }
    }
}
