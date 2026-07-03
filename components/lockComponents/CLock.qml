import QtQuick

import qs.services
import qs.theme

Text {
    id: clock
    text: Time.time
    property int size
    font {
        family: "Comfortaa"
        pixelSize: size
        weight: 500
    }
    color: Colors.color10
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    renderType: Text.NativeRendering
}
