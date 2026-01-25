pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> playerList: Mpris.players.values
    property MprisPlayer selectedPlayer: playerList.length > 0 ? playerList[activeIndex] : null
    readonly property MprisPlayer activePlayer: selectedPlayer
    property int activeIndex: 0
    property string playerName: selectedPlayer?.identity ?? ""

    onPlayerListChanged: {
        if (playerName !== "") {
            const index = playerList.findIndex(item => item.identity === playerName);
            activeIndex = index !== -1 ? index : 0;
        } else {
            activeIndex = 0;
        }
    }

    onActivePlayerChanged: {
        if (activePlayer) {
            activePlayer.positionChanged();
        }
    }
    readonly property real percentageProgress: {
        if (!activePlayer || !activePlayer.lengthSupported)
            return 0;
        return activePlayer.position / (activePlayer.length);
    }

    function selectPlayer(x: int) {
        activeIndex = (activeIndex + x+playerList.length) % playerList.length
    }

    FrameAnimation {
        running: root.activePlayer && root.activePlayer.playbackState == MprisPlaybackState.Playing
        onTriggered: if (root.activePlayer) {
            root.activePlayer.positionChanged();
        }
    }
}
