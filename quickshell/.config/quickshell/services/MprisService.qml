import Quickshell.Services.Mpris
import QtQuick
import Quickshell

Scope {
    property MprisPlayer player: Mpris.players.values[0]
}
