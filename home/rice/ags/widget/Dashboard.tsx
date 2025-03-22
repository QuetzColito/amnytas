import { App, astalify } from "astal/gtk3"
import { Variable, GLib, bind, Binding } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import { subprocess, execAsync } from "astal/process"
import { timeout } from "astal/time"
import Hyprland from "gi://AstalHyprland"
import Battery from "gi://AstalBattery"
import AstalHyprland from "gi://AstalHyprland?version=0.1"


function Clock() {
    const hours = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format("%H")!)
    const minutes = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format("%M")!)
    const seconds = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format("%S")!)
    return <box
        className="clock-widget"
        valign={Gtk.Align.FILL}
        homogeneous={true}
        vexpand={true}
        hexpand={false}>
        <label label={bind(hours)} className="hours" />
        <label label={bind(minutes)} className="minutes" />
        <label label={bind(seconds)} className="seconds" />
    </box>
}

type ButtonProps = {
    command: string
    color: string
    icon: string
}

function ControlButton({ command, color, icon }: ButtonProps) {
    return <box
        className="button"
        homogeneous={true}>
        <eventbox
            className={color}
            cursor="pointer"
            halign={Gtk.Align.FILL}
            onClick={() => subprocess(command)}>
            <label label={icon} />
        </eventbox>
    </box>
}

const update_timer: () => number[] = () => {
    let [_, target, last_time] = timer.get();
    if (target === Infinity) { return timer.get() }
    if (Date.now() <= target) {
        return [Math.floor((target - Date.now()) / 1000), target, last_time]
    } else {
        print("KURU KURU!");
        subprocess("hyprctl dispatch exec mpg123 ~/amnytas/home/rice/ags/alert.mp3");
        timer.stopPoll();
        timer_running.set(false);
        return [last_time, Infinity, last_time]
    }
}

const update_time = (time: number) => {
    let [_, target, last_time] = timer.get();
    timer.set([time, target, last_time])
}

const setTimer = (run: boolean) => {
    let [time, _, last_time] = timer.get();
    if (run) {
        timer.set([time, Date.now() + time * 1000, time])
        timer.startPoll();
    } else {
        timer.stopPoll();
        timer.set([time, Infinity, last_time])
    }
    timer_running.set(run);
}

const timer = Variable([0, Infinity, 0]).poll(1000, update_timer);
const timer_running = Variable(false);

const timer_state = (timer: number[]) => {
    let [t, r, l] = timer;
    if (!r || (t / l) > .66) return " ";
    if ((t / l) > .33) return " ";
    return " "
}

type WheelProps = {
    magnitude: number
    bound: number
    deco: string
}

function Wheel({ magnitude, bound, deco }: WheelProps) {
    return <eventbox
        onScroll={(_, e) => e.delta_y < 0
            ? update_time(timer.get()[0] + magnitude)
            : update_time(Math.max(timer.get()[0] - magnitude, 0))}>
        <label
            className="wheel"
            valign={Gtk.Align.CENTER}
            label={bind(timer).as(t => {
                const v = Math.floor((t[0] % bound) / magnitude)
                return `${v < 10 ? "0" : ""}${v}${deco}`
            })}
        />
    </eventbox>
}

function Timer() {
    return <box
        className={bind(timer_running).as(tr => `timer-widget ${tr ? "purple" : "orange"}`)}
        homogeneous={true}
        vertical={true}>
        <box
            valign={Gtk.Align.FILL}
            homogeneous={true}
            vexpand={true}>
            <Wheel magnitude={3600} bound={86400} deco="H" />
            <Wheel magnitude={60} bound={3600} deco="M" />
            <Wheel magnitude={1} bound={60} deco="S" />
        </box>
        <box
            valign={Gtk.Align.FILL}
            homogeneous={true}
            vexpand={true}>
            <label className="icon" label={bind(timer).as(t => timer_state(t))} />
            <button
                onClick={() => setTimer(!timer_running.get())}>
                <label className="icon" label={bind(timer_running).as(tr => tr ? "" : "")} />
            </button>
            <button
                on_clicked={() => { setTimer(false); update_time(timer.get()[2]) }}>
                <label className="icon" label="󰜉 " />
            </button>
        </box>
    </box>
}

const calc_result = Variable("0")

function Calculator() {
    return <box className="calculator-widget"
        homogeneous={true}
        vertical={true}
        vexpand={true}
        valign={Gtk.Align.FILL}>
        <entry
            halign={Gtk.Align.FILL}
            className="calc-input"
            onChanged={({ text }) => execAsync(["calc", text])
                .then(out => calc_result.set(out.trim()))
                .catch(() => { })}
            onActivate={() => execAsync(["wl-copy", calc_result.get()])}
        />
        <label
            className="calc-result"
            halign={Gtk.Align.END}
            label={bind(calc_result).as(r => `= ${r}`)}
        />
    </box>
}

// ----- Rando ----- //

const diemax = Variable(6);
const dievalue = Variable(1);
const randomize = () => [20, 50, 80, 110, 140, 160].forEach(i => {
    timeout(i, () => {
        dievalue.set(Math.ceil(Math.random() * (diemax.get())))
    })
})

function Rando() {
    return <box className="rando-widget cyan"
        homogeneous={true}>
        <eventbox
            onScroll={(_, e) => e.delta_y < 0
                ? diemax.set(diemax.get() + 1)
                : diemax.set(Math.max(diemax.get() - 1, 2))}>
            <label label={bind(diemax).as(v => v + "")} />
        </eventbox>
        <button
            on_clicked={() => randomize()}>
            <Dieface />
        </button>
    </box >
}

function Dieface() {
    return <stack visibleChildName={bind(diemax).as(m => m < 10 ? 'die' : 'numeric')}>
        <box name="die"
            className="die"
            homogeneous={true}
            vertical={true} >
            <box
                homogeneous={true} >
                <Diedot values={[4, 5, 6, 7, 8, 9]} />
                <Diedot values={[8, 9]} />
                <Diedot values={[2, 3, 4, 5, 6, 7, 8, 9]} />
            </box>
            <box
                homogeneous={true} >
                <Diedot values={[6, 7, 8, 9]} />
                <Diedot values={[1, 3, 5, 7, 9]} />
                <Diedot values={[6, 7, 8, 9]} />
            </box >
            <box
                homogeneous={true} >
                <Diedot values={[2, 3, 4, 5, 6, 7, 8, 9]} />
                <Diedot values={[8, 9]} />
                <Diedot values={[4, 5, 6, 7, 8, 9]} />
            </box >
        </box >

        <label name="numeric" label={bind(dievalue).as(v => v + "")} />
    </stack>
}

type DotProps = {
    values: number[]
}

function Diedot({ values }: DotProps) {
    return <box className="dot"
        css={bind(dievalue).as(v => values.includes(v) ? "" : "opacity: 0")}
    />
}

const round = (x: number) => Math.round(x * 100)
const divide = ([total, free]: number[]) => round(free / total)
const trim = (str: string) => str.substring(0, str.length - 1);

const cpu = Variable(0).poll(2000, "top -b -n 1",
    out => divide([100, 100 - parseInt(out.split('\n')[2].split(/\s+/)[7].replace(',', '.'))])
)

const ram = Variable(0).poll(2000, 'free',
    out => {
        const values = out.split('\n')[1].split(/\s+/)
        return divide([parseInt(values[1]), parseInt(values[2])])
    }
)

const storage1 = Variable(0).poll(2000, 'df',
    out => parseInt(trim(out.split('\n')
        .map(line => line.split(/\s+/))
        .find(line => line[5] === "/")!
        .splice(4, 1)[0]))
)

const battery = Battery.get_default()

const storage2 = Variable(0).poll(2000, 'df',
    out => parseInt(trim(out.split('\n')
        .map(line => line.split(/\s+/))
        .find(line => line[5].includes('/storage'))!
        .splice(4, 1)[0]))
)


type MonitorProps = {
    color: string
    value: Binding<number>
    icon: string | Binding<string>
}

function Monitor({ color, value, icon }: MonitorProps) {
    return <box
        halign={Gtk.Align.CENTER}
        vertical={true}
        className={`${color} monitor`}>
        <box homogeneous={true} className="stats">
            <label label={value.as(p => `${p}%`)} />
            <label label={icon} className="icon" />
        </box>
    </box>
}

// <slider widthRequest={40} value={value.as(p => p / 100)} />

const GCalendar = astalify(Gtk.Calendar)
function Calendar() {
    return <box
        className="calendar-widget"
        hexpand={true} >
        <GCalendar
            valign={Gtk.Align.CENTER}
            hexpand={true}
            showDayNames={true}
            showDetails={true}
            showHeading={true}
            showWeekNumbers={true} />
    </box >
}
const hyprland = Hyprland.get_default()

const isVisible = Variable(false);
const toGdkMonitor = (m: AstalHyprland.Monitor) => {
    return App.get_monitors().find(gm => gm.model === m.model)!
}

const getActiveMonitor = () => {
    return hyprland.focused_monitor
}

const monitor = Variable(getActiveMonitor())

export function toggleDashboard() {
    monitor.set(getActiveMonitor())
    isVisible.set(!isVisible.get())
}

export default function Dashboard() {
    return <window
        name="dashboard"
        setup={self => App.add_window(self)}
        gdkmonitor={bind(monitor).as(toGdkMonitor)}
        namespace={'dashboard'}
        visible={bind(isVisible)}
        keymode={Astal.Keymode.ON_DEMAND}
        layer={Astal.Layer.OVERLAY}>
        <box vertical={true}>
            <Clock />
            <box className="control-buttons" homogeneous={true} spacing={10}>
                <ControlButton command="shutdown now" color="red" icon=" " />
                <ControlButton command="reboot" color="orange" icon="󰜉" />
                <ControlButton command="hyprctl dispatch exec -- uwsm stop" color="green" icon="󰗽 " />
                <ControlButton command="hyprctl dispatch exec -- hyprlock --immediate" color="yellow" icon=" " />
            </box>
            <Calendar />
            <box homogeneous={true}>
                <Timer />
                <Rando />
                <Calculator />
            </box>
            <box className="monitors" homogeneous={true}>
                <Monitor color="cyan" value={bind(cpu)} icon=" " />
                <Monitor color="blue" value={bind(ram)} icon=" " />
                <Monitor color="purple" value={bind(storage1)} icon=" " />
                {battery.isPresent
                    ? <Monitor
                        color="green"
                        value={bind(battery, "percentage").as(p => Math.round(p * 100))}
                        icon={bind(battery, "charging").as(c => c ? "󱐥" : "󱐤")}
                    />
                    : <Monitor color="green" value={bind(storage2)} icon=" " />
                }
            </box>
        </box>
    </window>

}
