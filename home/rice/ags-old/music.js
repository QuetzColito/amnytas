// ----- Audio Bar ----- //

const audio = await Service.import('audio')

export const Audio = () => Widget.EventBox({
    class_name: "sound",
    on_primary_click: () => audio.speaker.is_muted = !audio.speaker.is_muted,
    on_scroll_up: () => audio.speaker.volume = audio.speaker.volume + 0.05,
    on_scroll_down: () => audio.speaker.volume = audio.speaker.volume - 0.05,
    child: Widget.Label().hook(audio.speaker, self => {
        const vol = audio.speaker.volume * 100;
        self.label = `   ${Math.ceil(vol)}%`;
    }),
})

// ----- Music Bar ----- //

const mpris = await Service.import('mpris')
const players = Utils.watch("", mpris, "player-changed", () => mpris.players)

const viewLoop = (loop_status) => {
    if (loop_status === "Track") return "󰑘";
    if (loop_status === "Playlist") return "󰑖";
    return ""
}

export const Music = () => Widget.Box({
    children: players.as(p => [music(p[0])]),
})

const music = (p) => Widget.EventBox({
    class_name: `music ${p.play_back_status === "Playing" ? "purple" : "orange"}`,
    visible: !p.name.includes("firefox"),
    on_primary_click: () => p?.playPause(),
    on_scroll_up: () => p?.next(),
    on_scroll_down: () => p?.previous(),
    child: Widget.Label({ label: `${viewLoop(p.loop_status)} ${ p.play_back_status === "Playing" ? "" : ""} ${p.track_artists.join(", ")} - ${p.track_title}`, truncate: "end" }),
})

// ----- Music Dashboard ----- //

export const Player = () => Widget.Box({
    children: players.as(p => [player(p[0])]),
})

const player = (p) => Widget.Box({
    class_name: "music-widget",
    vertical: true,
    children: [
        Widget.Label({
            class_name: "title",
            wrap: true,
            hpack: "start",
            label: p.bind("track-title")
        }),
        Widget.Label({
            class_name: "artist",
            wrap: true,
            hpack: "end",
            label: p.bind("track-artists").as(artists => artists.join(', '))
        }),
        Widget.Label({}),
        Widget.Box({
            children: [
                Widget.Box({
                    class_name: "img",
                    vpack: "start",
                    css: p.bind("cover_path").transform(path => `
                        background-image: url('${path}');
                    `),
                }),
                music_controls(p)
            ]

        })
    ]
})

const music_controls = (p) => Widget.Box({
    class_name: "music-control-center",
    vertical: true,
    children: [
        Widget.Box({
            class_name: "sound-scale",
            children: [
                Widget.Label({ label: " ", class_name: "scale-icon"}),
                Widget.Slider({
                    min: 0, max: 1, value: p.bind("volume"),
                    draw_value: false,
                    widthRequest: 70, heightRequest: 30,
                    on_change: ({ value }) => {Utils.exec(`playerctl volume ${value}`) ;},
                })
            ]
        }),
        Widget.Box({
            homogeneous: true,
            children: [
                Widget.Button({
                    on_clicked: () => p?.previous(),
                    child: Widget.Label({label: "󰼨"})
                }),
                Widget.Button({
                    on_clicked: () => p?.playPause(),
                    child: Widget.Label({label: `${p.play_back_status === "Playing" ? "" : ""}`})
                }),
                Widget.Button({
                    on_clicked: () => p?.next(),
                    child: Widget.Label({label: "󰼧"})
                }),
            ]
        }),
        Widget.Box({
            class_name: "duration-scale",
            children: [
                Widget.Label({ label: " ", class_name: "scale-icon"}),
                Widget.Slider({
                    min: 0, max: 1, value: Utils.merge([p.bind("position"), p.bind("length")], (pos, l) => pos / l),
                    draw_value: false,
                    widthRequest: 70, heightRequest: 30,
                    on_change: ({ value }) => {p.position = value * p.length ;},
                    setup: self => {
                        function update() {
                            const value = p.position / p.length
                            self.value = value > 0 ? value : 0
                        }
                        self.hook(player, update)
                        self.hook(player, update, "position")
                        self.poll(1000, update)
                    },
                })
            ]
        }),
    ]
})
