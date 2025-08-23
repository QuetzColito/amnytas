pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    property UPowerDevice battery: UPower.devices.values.find(d => d.isLaptopBattery)
    property bool hasBattery: battery
    property bool charging: battery.state != UPowerDeviceState.Discharging
    property real charge: battery.percentage
}
