pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool networking: false
    property string connectivity: ""
    property bool hasWifi: false
    property bool wifiEnabled: false
    property list<var> connections: []
    property list<var> networks: []

    function reScan(): void {
        checkNetworking.running = true;
    }

    function toggleNetworking(): void {
        Quickshell.execDetached(["sh", "-c", `nmcli n ${root.networking ? "off" : "on"}`]);
        reScan();
    }

    function toggleWifi(): void {
        toggleWifi.running = true;
    }

    function canConnect(ssid: string): var {
        return connections.find(c => c.name == ssid)?.uuid;
    }

    function connect(uuid: string): void {
        connect.uuid = uuid;
        connect.running = true;
    }

    function connectNew(ssid: string, password: string): bool {
        connectNew.ssid = ssid;
        connectNew.password = password.trim();
        connectNew.running = true;
    }

    Process {
        id: toggleNetworking
        command: ["sh", "-c", `nmcli n ${root.networking ? "off" : "on"}`]
        stdout: StdioCollector {
            onStreamFinished: root.reScan()
        }
    }

    Process {
        id: toggleWifi
        command: ["sh", "-c", `nmcli r w ${root.wifiEnabled ? "off" : "on"}`]
        stdout: StdioCollector {
            onStreamFinished: root.reScan()
        }
    }

    Process {
        id: connect
        property string uuid: ""
        command: ["sh", "-c", `nmcli c u ${uuid}`]
        stdout: StdioCollector {
            onStreamFinished: root.reScan()
        }
    }

    Process {
        id: connectNew
        property string ssid: ""
        property string password: ""
        command: ["sh", "-c", `nmcli d w c '${ssid}' ${password ? "password '" + password + "'" : ""}`]
        stdout: StdioCollector {
            onStreamFinished: root.reScan()
        }
    }

    Process {
        id: checkNetworking
        running: true
        command: ["sh", "-c", "nmcli -t n"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.networking = text.trim() === "enabled";
                if (root.networking)
                    checkConnectivity.running = true;
            }
        }
    }

    Process {
        id: checkConnectivity
        command: ["sh", "-c", "nmcli -t n c c"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.connectivity = text;
                checkHasWifi.running = true;
            }
        }
    }

    Process {
        id: checkHasWifi

        command: ["sh", "-c", "nmcli -t -f TYPE d"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.hasWifi = text.split("\n").includes("wifi");
                if (root.hasWifi)
                    checkWifiEnabled.running = true;
            }
        }
    }

    Process {
        id: checkWifiEnabled

        command: ["sh", "-c", "nmcli r w"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.wifiEnabled = text.trim() === "enabled";
                checkConnections.running = true;
            }
        }
    }

    Process {
        id: checkConnections

        command: ["sh", "-c", "nmcli -t -f NAME,TYPE,UUID c"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.connections = text.split("\n").filter(c => c).map(c => {
                    const [name, type, uuid] = c.split(":");
                    return {
                        "name": name,
                        "type": type,
                        "uuid": uuid
                    };
                });

                root.connections = root.connections.filter(c => c.type.includes("wireless"));
                scanWifi.running = true;
            }
        }
    }

    Process {
        id: scanWifi

        command: ["sh", "-c", "nmcli -t -f IN-USE,SSID,SIGNAL d w"]
        stdout: StdioCollector {
            onStreamFinished: {
                const networkMap = new Map();
                root.networks = [];
                text.split("\n").filter(n => n).map(n => {
                    const [use, ssid, strength] = n.split(":");
                    return {
                        "use": use.trim() === "*",
                        "ssid": ssid,
                        "strength": strength
                    };
                }).filter(n => n.ssid).forEach(n => {
                    const n2 = networkMap.get(n.ssid);
                    if (n2) {
                        networkMap.set(n.ssid, {
                            "use": n2.use || n.use,
                            "ssid": n.ssid,
                            "strength": Math.max(n.strength, n2.strength)
                        });
                    } else
                        networkMap.set(n.ssid, n);
                });
                let index = 0;
                for (const n of networkMap.values()) {
                    if (n.use)
                        root.networks.unshift(n);
                    else if (root.connections.find(c => c.ssid === n.ssid)) {
                        root.networks.splice(index, 0, n);
                        index++;
                    } else
                        root.networks.push(n);
                }
            }
        }
    }
}
