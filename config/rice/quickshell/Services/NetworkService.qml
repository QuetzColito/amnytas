pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool hasWifi: false

    function reScan(): void {
        checkHasWifi.running = true;
    }

    Process {
        id: checkNetworking

        // running: true
        command: ["sh", "-c", ""]
        stdout: StdioCollector {
            onStreamFinished: root.hasWifi = text.split("\n").map(s => s.trim()).includes("wifi")
        }
    }

    Process {
        id: checkHasWifi

        running: true
        command: ["sh", "-c", "nmcli -t -f TYPE d"]
        stdout: StdioCollector {
            onStreamFinished: root.hasWifi = text.split("\n").includes("wifi")
        }
    }
}
