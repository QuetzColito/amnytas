pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    property var p: Mpris.players.values.find(p => !p.identity.includes("firefox"))
}
