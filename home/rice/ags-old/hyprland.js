// ----- Hyprland ----- //

const hyprland = await Service.import('hyprland')

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);

export const Workspaces = () => Widget.EventBox({
    class_name: "workspaces",
    onScrollUp: () => dispatch('+1'),
    onScrollDown: () => dispatch('-1'),
    child: Widget.Box({
        children: Array.from({ length: 9 }, (_, i) => i + 1).map(i => Widget.EventBox({
            attribute: i,
            child: Widget.Box({
                class_name: hyprland.active.workspace.bind("id").as(active => active == i ? "workspace-entry current" : "workspace-entry"),
                children: [
                    Widget.Label({
                        label: hyprland.bind("workspaces").as(wss => wss.find(ws => ws.id === i)?.windows > 0 ? " ◆ " : " ◇ "),
                        class_name: "workspace",
                    }),
                    Widget.Label({
                        label: i == 3 || i == 6 ? " | " : "  ",
                        class_name: "separator",
                    })
                ]
            }),
            on_primary_click: () => dispatch(i),
        })),
    }),
})
