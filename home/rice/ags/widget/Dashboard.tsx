import { App } from "astal/gtk3"
import { Variable, GLib, bind, Binding } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import { subprocess } from "astal/process"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
import Battery from "gi://AstalBattery"
import Tray from "gi://AstalTray"
import Wp from "gi://AstalWp"
import AstalMpris from "gi://AstalMpris?version=0.1"

const hyprland = Hyprland.get_default()

const isVisible = Variable(true);
const getActiveMonitor = () => {
    const fmodel = hyprland.get_focused_monitor().model;
    return App.get_monitors().find(m => m.model === fmodel)!
}
const monitor = Variable(getActiveMonitor())

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


const timer = Variable(0).poll(1000, () => {
    if (!timer_running.get()) return timer.get();
    if (Date.now() <= target.get()) {
        return Math.floor((target.get() - Date.now()) / 1000)
    } else {
        print("KURU KURU!")
        target.set(Infinity)
        timer_running.set(false)
        subprocess("hyprctl dispatch exec mpg123 ~/amnytas/home/rice/eww/alert.mp3")
        return last_timer.get()
    }
}: string
);

const timer_running = Variable(false);
const last_timer = Variable(0);
const target = Variable(Infinity);
// const timerState = Utils.merge([timer.bind(), timer_running.bind(), last_timer.bind()], (t, r, l) => {
//     if (!r || (t / l) > .66) return " ";
//     if ((t / l) > .33) return " ";
//     return " "
// })
//
type WheelProps = {
    magnitude: number
    bound: number
    deco: string
}

function Wheel({ magnitude, bound, deco }: WheelProps) {
    return <eventbox
        onScroll={(_, e) => e.delta_y < 0
            ? timer.set(timer.get() + magnitude)
            : timer.set(Math.max(timer.get() - magnitude, 0))}>
        <label
            className="wheel"
            valign={Gtk.Align.CENTER}
            label={bind(timer).as(t => {
                const v = Math.floor((t % bound) / magnitude)
                return `${v < 10 ? "0" : ""}${v}${deco}`
            })}
        />
    </eventbox>
}

function countdown() {
    if (timer_running.get()) {
        timer_running.set(false)
        target.set(Infinity)
        return;
    }
    target.set(Date.now() + timer.get() * 1000)
    last_timer.set(timer.get())
    timer_running.set(true)
}


function Timer() {
    <box
        setup={self => {
            function update() {
                if (!timer_running.value) return;
                if (Date.now() <= target.value) {
                    timer.value = Math.floor((target.value - Date.now()) / 1000)
                } else {
                    print("KURU KURU!")
                    target.set(Infinity)
                    timer_running.set(false)
                    subprocess("hyprctl dispatch exec mpg123 ~/amnytas/home/rice/eww/alert.mp3")
                }
            }
            self.poll(1000, update)
        }}
        className={bind(timer_running).as(tr => `timer-widget ${tr ? "purple" : "orange"}`)}
        homogeneous={true}
        vertical={true}>
        <box
            valign={Gtk.Align.FILL}
            homogeneous={true}
            vexpand={true}>
            wheel(3600, 86400, "H"),
            wheel(60, 3600, "M"),
            wheel(1, 60, "S")
        </box>
        <box
            valign={Gtk.Align.FILL}
            homogeneous={true}
            vexpand={true}>
            <label className="icon" label={"I"} />
            <button
                onClick={() => countdown()}>
                <label className="icon" label={bind(timer_running).as(tr => tr ? "" : "")} />
            </button>
            <button
                on_clicked={() => { timer_running.set(false); timer.set(last_timer.get()) }}>
                <label className="icon" label="󰜉 " />
            </button>
        </box>
    </box>
}

const round = (x: number) => Math.round(x * 100)
const divide = ([total, free]: number[]) => round(free / total)
const trim = (str: string) => str.substring(0, str.length - 1);

const cpu = Variable(0).poll(2000, 'top -b -n 1',
    out => divide([100, parseInt(out.split('\n')
        .find(line => line.includes('Cpu(s)'))!
        .split(/\s+/)[1]
        .replace(',', '.'))])
)

const ram = Variable(0).poll(2000, 'free | grep "Mem:"',
    out => divide(out
        .split(/\s+/)
        .splice(1, 2)
        .map(parseInt))
)

const storage1 = Variable(0).poll(2000, 'df',
    out => parseInt(trim(out.split('\n')
        .map(line => line.split(/\s+/))
        .find(line => line[5] === "/")!
        .splice(4, 1)[0]))
)

const storage2 = Variable(0).poll(2000, 'df',
    out => parseInt(trim(out.split('\n')
        .map(line => line.split(/\s+/))
        .find(line => line[5].includes('/storage'))!
        .splice(4, 1)[0]))
)

const battery = Battery.get_default()

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
        <slider widthRequest={40} value={value.as(p => p / 100)} />
    </box>
}


export default function Dashboard() {
    return <window
        name="dashboard"
        setup={self => App.add_window(self)}
        gdkmonitor={bind(monitor)}
        namespace={'dashboard'}
        visible={bind(isVisible)}
        layer={Astal.Layer.OVERLAY}>
        <box vertical={true}>
            <Clock />
            <box className="control-buttons" homogeneous={true} spacing={10}>
                <ControlButton command="shutdown now" color="red" icon=" " />
                <ControlButton command="reboot" color="orange" icon="󰜉" />
                <ControlButton command="hyprctl dispatch exit" color="green" icon="󰗽 " />
                <ControlButton command="hyprctl dispatch exec hyprlock" color="yellow" icon=" " />
            </box>
            <box>
                <label label="test2" />
            </box>
            <box className="monitors" homogeneous={true}>
                <Monitor color="cyan" value={bind(cpu)} icon=" " />
                <Monitor color="blue" value={bind(ram)} icon=" " />
                <Monitor color="purple" value={bind(storage1)} icon=" " />
                {battery.isPresent
                    ? <Monitor
                        color="green"
                        value={bind(battery, "percentage")}
                        icon={bind(battery, "batteryIconName")}
                    />
                    : <Monitor color="green" value={bind(storage2)} icon=" " />
                }
            </box>
        </box>
    </window>

}
