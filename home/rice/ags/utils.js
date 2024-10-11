// ----- Timer ----- //

const timer = Variable(0);
const timer_running = Variable(false);
const last_timer = Variable(0);
const target = Variable(Infinity);
const timerState = Utils.merge([timer.bind(), timer_running.bind(), last_timer.bind()], (t, r, l) => {
    if (!r || (t / l) > .66) return " ";
    if ((t / l) > .33) return " ";
    return " "
})

const wheel = (magnitude, bound, deco) => Widget.EventBox({
    on_scroll_up: () => {timer.value = timer.value + magnitude},
    on_scroll_down: () => {timer.value = Math.max(timer.value - magnitude, 0)},
    child: Widget.Label({
        class_name: "wheel",
        vpack: "center",
        label: timer.bind().as( t => {
            const v = Math.floor((t % bound) / magnitude);
            return `${v < 10 ? "0": ""}${v}${deco}`
        })
    })
})

function countdown() {
    if (timer_running.value) {
        timer_running.value = false
        target.value = Infinity
        return;
    }
    target.value = Date.now() + timer.value * 1000;
    last_timer.value = timer.value;
    timer_running.value = true;
}


const Timer = () => Widget.Box({
    class_name: timer_running.bind().as(tr =>`timer-widget ${tr ? "purple" : "orange"}`),
    homogeneous: true,
    vertical: true,
    children: [
        Widget.Box({
            vpack: "fill",
            homogeneous: true,
            vexpand: true,
            children: [
                wheel(3600, 86400, "H"),
                wheel(60, 3600, "M"),
                wheel(1, 60, "S")
            ]
        }),
        Widget.Box({
            vpack: "fill",
            homogeneous: true,
            vexpand: true,
            children: [
                Widget.Label({class_name: "icon", label: timerState}),
                Widget.Button({
                    on_clicked: () => countdown(),
                    child: Widget.Label({class_name: "icon", label: timer_running.bind().as(tr => tr ? "" : "")}),
                }),
                Widget.Button({
                    on_clicked: () => {timer_running.value = false; timer.value = last_timer.value},
                    child: Widget.Label({class_name: "icon", label: "󰜉 "}),
                })
            ]
        })
    ],
    setup: self => {
        function update() {
            if (!timer_running.value) return;
            if (Date.now() <= target.value) {
                timer.value = Math.floor((target.value - Date.now()) / 1000)
            } else {
                print("KURU KURU!")
                target.value = Infinity
                timer_running.value = false
                Utils.exec("hyprctl dispatch exec mpg123 ~/nixos/home/rice/eww/alert.mp3")
            }
        }
        self.poll(1000, update)
    },
})

// ----- Calculator ----- //

const calc_result = Variable("0")

const Calculator = () => Widget.Box({
    class_name: "calculator-widget",
    homogeneous: true,
    vertical: true,
    vexpand: true,
    vpack: "fill",
    children: [
        Widget.Entry({
            hpack: "fill",
            class_name: "calc-input",
            on_change: ({text}) => Utils.execAsync(["calc", text])
                                        .then(out => calc_result.value = out.trim())
                                        .catch(() => {}),
            on_accept: () => Utils.execAsync(["wl-copy", calc_result.value])
        }),
        Widget.Label({
            class_name: "calc-result",
            hpack: "end",
            label: calc_result.bind().as(r => `= ${r}`)
        })
    ]
})

// ----- Rando ----- //

const diemax = Variable(6);
const dievalue = Variable(1);
const randomize = () => [20, 50, 80, 110, 140, 160].forEach(i => {
    Utils.timeout(i, () => {
        dievalue.value = Math.ceil(Math.random() * (diemax.value - 1) + 1)
    })
})

const Rando = () => Widget.Box({
    class_name: "rando-widget cyan",
    homogeneous: true,
    children: [
        Widget.EventBox({
            on_scroll_up: () => {diemax.value = diemax.value + 1},
            on_scroll_down: () => {diemax.value = Math.max(diemax.value - 1, 2)},
            child: Widget.Label({ label: diemax.bind().as(v => v + "") })
        }),
        Widget.Button({
            on_clicked: () => randomize(),
            child: diefacee()
        })
    ]
})

const diefacee = () => Widget.Stack({
    shown: diemax.bind().as(m => m < 10 ? 'die' : 'numeric'),
    children: {
        'die': Widget.Box({
            class_name: "die",
            homogeneous: true,
            vertical: true,
            children: dievalue.bind().as(v => [
                Widget.Box({
                    homogeneous: true,
                    children: [
                        diedot(v, [4, 5, 6, 7, 8, 9]),
                        diedot(v, [8, 9]),
                        diedot(v, [2, 3, 4, 5, 6, 7, 8, 9])
                    ]
                }),
                Widget.Box({
                    homogeneous: true,
                    children: [
                        diedot(v, [6, 7, 8, 9]),
                        diedot(v, [1, 3, 5, 7, 9]),
                        diedot(v, [6, 7, 8, 9])
                    ]
                }),
                Widget.Box({
                    homogeneous: true,
                    children: [
                        diedot(v, [2, 3, 4, 5, 6, 7, 8, 9]),
                        diedot(v, [8, 9]),
                        diedot(v, [4, 5, 6, 7, 8, 9])
                    ]
                }),
            ])

        }),
        'numeric': Widget.Label({
            class_name: "result",
            label: dievalue.bind().as(v => v + "")
        })
    }
})
const dieface = () => Widget.Overlay({
    child: Widget.Box({
        class_name: "die",
        homogeneous: true,
        vertical: true,
        css: diemax.bind().as(m => m > 9 ? "opacity: 0" : ""),
        children: dievalue.bind().as(v => [
            Widget.Box({
                homogeneous: true,
                children: [
                    diedot(v, [4, 5, 6, 7, 8, 9]),
                    diedot(v, [8, 9]),
                    diedot(v, [2, 3, 4, 5, 6, 7, 8, 9])
                ]
            }),
            Widget.Box({
                homogeneous: true,
                children: [
                    diedot(v, [6, 7, 8, 9]),
                    diedot(v, [1, 3, 5, 7, 9]),
                    diedot(v, [6, 7, 8, 9])
                ]
            }),
            Widget.Box({
                homogeneous: true,
                children: [
                    diedot(v, [2, 3, 4, 5, 6, 7, 8, 9]),
                    diedot(v, [8, 9]),
                    diedot(v, [4, 5, 6, 7, 8, 9])
                ]
            }),
        ])

    }),
    overlays: [Widget.Label({
        class_name: "result",
        css: diemax.bind().as(m => m < 10 ? "opacity: 0" : ""),
        label: dievalue.bind().as(v => v + "")
    })]
})

const diedot = (v, values) => Widget.Label({
    class_name: "dot",
        css: values.includes(v) ? "" : "opacity: 0",
})


export const utils = Widget.Box({
    homogeneous: true,
    children: [Timer(), Rando(), Calculator()]
})
