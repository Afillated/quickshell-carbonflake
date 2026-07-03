import QtQuick

import qs.services
import qs.theme

Text {
    id: date
    text: Time.date
    color: Colors.color10
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    property int size
    font {
        family: "Comfortaa"
        pixelSize: size
        weight: 500
    }
    renderType: Text.NativeRendering
}
