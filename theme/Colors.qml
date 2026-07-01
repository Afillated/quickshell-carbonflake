pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

import qs.services

Singleton {
    id: root
    property var _wallpaper: Wallpaper
    property color background: "#080302"
    property color transground: "#33080302"
    property color transground2: "#66080302"
    property color transground3: "#AA080302"
    property color transground4: "#CC080302"
    property color foreground: "#FF6049"
    property color cursor: "#E63428"

    property color color0: "#0C0403"
    property color color1: "#673B3B"
    property color color2: "#7A3C3D"
    property color color3: "#8C3D3D"
    property color color4: "#9E3E3E"
    property color color5: "#B13E3E"
    property color color6: "#C33E3E"
    property color color7: "#FF4E3A"
    property color color8: "#E20000"
    property color color9: "#753C3C"
    property color color10: "#903D3E"
    property color color11: "#A83E3E"
    property color color12: "#C03F3F"
    property color color13: "#D8403F"
    property color color14: "#EC0707"
    property color color15: "#F79E94"

    readonly property FileView configFile: FileView {
        id: colorFile
        path: Qt.resolvedUrl("./colors.json")
        watchChanges: true
        onFileChanged: {
            reload();
        }
        onLoaded: {
            try {
                const file = JSON.parse(text());
                if (file.background !== undefined)
                    root.background = file.background;
                if (file.transground !== undefined)
                    root.transground = file.transground;
                if (file.transground1 !== undefined)
                    root.transground1 = file.transground1;
                if (file.transground2 !== undefined)
                    root.transground2 = file.transground2;
                if (file.transground3 !== undefined)
                    root.transground3 = file.transground3;
                if (file.transground4 !== undefined)
                    root.transground4 = file.transground4;
                if (file.foreground !== undefined)
                    root.foreground = file.foreground;
                if (file.cursor !== undefined)
                    root.cursor = file.cursor;
                if (file.color0 !== undefined)
                    root.color0 = file.color0;
                if (file.color1 !== undefined)
                    root.color1 = file.color1;
                if (file.color2 !== undefined)
                    root.color2 = file.color2;
                if (file.color3 !== undefined)
                    root.color3 = file.color3;
                if (file.color4 !== undefined)
                    root.color4 = file.color4;
                if (file.color5 !== undefined)
                    root.color5 = file.color5;
                if (file.color6 !== undefined)
                    root.color6 = file.color6;
                if (file.color7 !== undefined)
                    root.color7 = file.color7;
                if (file.color8 !== undefined)
                    root.color8 = file.color8;
                if (file.color9 !== undefined)
                    root.color9 = file.color9;
                if (file.color10 !== undefined)
                    root.color10 = file.color10;
                if (file.color11 !== undefined)
                    root.color11 = file.color11;
                if (file.color12 !== undefined)
                    root.color12 = file.color12;
                if (file.color13 !== undefined)
                    root.color13 = file.color13;
                if (file.color14 !== undefined)
                    root.color14 = file.color14;
                if (file.color15 !== undefined)
                    root.color15 = file.color15;
            } catch (e) {
                console.warn("[Colors] JSON Error: " + e.message);
            }
        }
    }
}
