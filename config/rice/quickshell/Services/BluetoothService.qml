pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    property BluetoothAdapter defaultAdapter: Bluetooth.defaultAdapter
    property var devices: defaultAdapter?.devices
    property bool isPresent: defaultAdapter || false
    property bool enabled: defaultAdapter?.enabled || false
    property bool discovering: defaultAdapter?.discovering || false

    function scan(active: bool): void {
        defaultAdapter.discovering = active;
        cancelSearch.running = active;
    }

    Timer {
        id: cancelSearch
        running: false
        interval: 30000
        onTriggered: root.defaultAdapter.discovering = false
    }
}
