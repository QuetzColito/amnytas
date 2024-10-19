import { Music, Player, Audio } from './music.js'
import { Buttons } from './buttons.js'
import { Monitors } from './monitors.js'
import { Calendar, Clock, Time } from './time.js'
import { SysTray } from './sysTray.js'
import { Workspaces } from './hyprland.js'
import { utils } from './utils.js'

// ----- Recording Indicator ----- //

const recording = Variable(false)
globalThis.recording = recording

const Recording = () => Widget.Label({
    visible: recording.bind(),
    class_name: "red",
    label: "  "
})

// ----- Bar ----- //
const Bar = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    exclusivity: "exclusive",
    anchor: ['top', 'left', 'right'],
    child: Widget.CenterBox({
        start_widget: BarArea("start", [Workspaces()]),
        center_widget: BarArea("center", [Recording(), Time()]),
        end_widget: BarArea("end", [Music(), Audio(), SysTray()]),
    }),
})

const BarArea = (align = "start", items = []) => Widget.Box({
    class_name: "bar-area",
    hpack: align,
    children: items,
})

// ----- Dashboard ----- //

const hyprland = await Service.import('hyprland')

const dashboard = () => Widget.Window({
    monitor: hyprland.active.monitor.bind("id"),
    name: "dashboard",
    anchor: [],
    layer: "overlay",
    keymode: "on-demand",
    visible: false,
    child: Widget.Box({
        vertical: true,
        children: [
            Clock,
            Buttons,
            Widget.Box({ children: [Calendar, Player()], homogeneous: true }),
            utils,
            Monitors
        ]
    }),
})

// ----- App ----- //

const scss = `${App.configDir}/style.scss`
const css = `/tmp/ags-style.css`
Utils.exec(`sassc ${scss} ${css}`)

App.config({
    style: css,
    windows: [dashboard(), ...hyprland.monitors.map(m => Bar(m.id))]
})
