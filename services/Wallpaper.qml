pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string current: ""
    property bool autoRotate: true
    property bool ready: false
    property bool daemonReady: false

    readonly property string defaultPath: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    property string configuredPath: defaultPath

    property int intervalMinutes: 30
    property string transition: "wipe"
    property real transitionDuration: 1.5
    property int transitionAngle: 30
    property int transitionFps: 60

    property var wallpaperList: []
    property bool pathIsFile: false
    property int lastIndex: -1

    Component.onCompleted: {
        console.log("[Wallpaper] Initializing Service...");
        killAwww.running = true;
    }

    Process {
        id: killAwww
        command: ["pkill", "awww-daemon"]
        onExited: startAwww.running = true
    }

    Process {
        id: startAwww
        command: ["awww-daemon"]
    }

    Timer {
        id: daemonWaitTimer
        interval: 1000
        running: startAwww.running
        repeat: false
        onTriggered: {
            console.log("[Wallpaper] Daemon should be ready now.");
            root.daemonReady = true;
            configView.reload();
        }
    }

    readonly property FileView configFile: FileView {
        id: configView
        path: Qt.resolvedUrl("../theme/wallSettings.json")
        onLoaded: {
            try {
                const cfg = JSON.parse(text());
                if (cfg.path !== undefined)
                    root.configuredPath = cfg.path.replace(/^~/, Quickshell.env("HOME"));
                if (cfg.intervalMinutes !== undefined)
                    root.intervalMinutes = cfg.intervalMinutes;
                if (cfg.transition !== undefined)
                    root.transition = cfg.transition;
                if (cfg.transitionFps !== undefined)
                    root.transitionFps = cfg.transitionFps;
                if (cfg.transitionAngle !== undefined)
                    root.transitionAngle = cfg.transitionAngle;
            } catch (e) {
                console.warn("[Wallpaper] JSON Error: " + e.message);
            }
            root.initPath();
        }
    }

    function initPath() {
        pathChecker.command = ["bash", "-c", `[ -f "${root.configuredPath}" ] && echo file || ([ -d "${root.configuredPath}" ] && echo dir || echo missing)`];
        pathChecker.running = false;
        pathChecker.running = true;
    }

    Process {
        id: pathChecker
        stdout: SplitParser {
            onRead: data => {
                if (data.trim() === "file") {
                    root.pathIsFile = true;
                    root.wallpaperList = [root.configuredPath];
                    root.setWallpaper(root.configuredPath);
                } else {
                    root.pathIsFile = false;
                    scanProcess.running = false;
                    scanProcess.running = true;
                }
            }
        }
    }

    Process {
        id: scanProcess
        command: ["bash", "-c", `find "${root.configuredPath}" -maxdepth 2 -type f \\( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \\) | sort`]
        stdout: StdioCollector {
            onStreamFinished: {
                const files = text.trim().split("\n").filter(f => f.length > 0);
                if (files.length > 0) {
                    root.wallpaperList = files;
                    root.ready = true;
                    console.log("[Wallpaper] Scanned " + files.length + " images.");
                    if (root.current === "")
                        root.pickRandom();
                }
            }
        }
    }

    function pickRandom() {
        if (wallpaperList.length === 0)
            return;
        let idx = lastIndex;
        if (wallpaperList.length > 1) {
            while (idx === lastIndex)
                idx = Math.floor(Math.random() * wallpaperList.length);
        } else {
            idx = 0;
        }
        lastIndex = idx;
        setWallpaper(wallpaperList[idx]);
    }

    function setWallpaper(path) {
        if (!path)
            return;
        console.log("[Wallpaper] Applying: " + path);
        root.current = path;

        awwwCmd.command = ["awww", "img", path, "--transition-type", root.transition, "--transition-fps", root.transitionFps.toString(), "--transition-step", root.transitionAngle.toString()];
        awwwCmd.running = false;
        awwwCmd.running = true;

        wallustCmd.command = ["wallust", "run", path];
        wallustCmd.running = false;
        wallustCmd.running = true;
    }

    Process {
        id: awwwCmd
    }
    Process {
        id: wallustCmd
    }

    Timer {
        interval: root.intervalMinutes * 60 * 1000
        running: root.autoRotate && !root.pathIsFile && root.wallpaperList.length > 1
        repeat: true
        onTriggered: root.pickRandom()
    }

    IpcHandler {
        target: "wallpaper"
        function next(): void {
            root.pickRandom();
        }
        function reload(): void {
            root.initPath();
        }
    }
}
