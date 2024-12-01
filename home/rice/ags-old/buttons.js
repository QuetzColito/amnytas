// ----- Buttons ----- //

const control_button = (command, color, icon) => Widget.Box({
    class_name: "button",
    homogeneous: true,
    children: [Widget.EventBox({
        class_name: color,
        cursor: "pointer",
        hpack: "fill",
        on_primary_click: () => Utils.exec(command),
        child: Widget.Label({ label: icon })
    })]
})

export const Buttons = Widget.Box({
    class_name: "control-buttons",
    homogeneous: true,
    spacing: 10,
    children: [
        control_button("shutdown now", "red", " "),
        control_button("reboot", "orange", "󰜉"),
        control_button("hyprctl dispatch exit", "green", "󰗽 "),
        control_button("hyprctl dispatch exec hyprlock", "yellow", " "),
    ]
})
