import { App } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
import Tray from "gi://AstalTray"
import Wp from "gi://AstalWp"
import AstalMpris from "gi://AstalMpris?version=0.1"
import { toggleDashboard } from "./Dashboard"

const hyprland = Hyprland.get_default()

function Time({ format = "%a   %d %b   %H:%M" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <eventbox
        className="time"
            cursor="pointer"
        onDestroy={() => time.drop()}
        onClick={() => toggleDashboard()}
    >
        <label label={time()}/>
  </eventbox>
}

const isRecording = Variable(false);

export function setRecording(value: boolean) {
    isRecording.set(value);
}

function Recording() {
    return <label
        className="red"
        label={bind(isRecording).as(v => v ? "  " : "")}
    />
}

function Audio() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    return <eventbox
        className="sound"
            cursor="pointer"
        onClick={(_, e) => {
            if (e.button === Astal.MouseButton.PRIMARY) {
                speaker.set_mute(!speaker.mute)
            } else {
                hyprland.message_async('dispatch exec pwvucontrol', null)
            }
        }}
        onScroll={(_, e) => speaker.set_volume(e.delta_y < 0 ? speaker.volume + 0.05 : speaker.volume - 0.05)}
    >
        <label
            label={bind(speaker, "volume").as(v => `   ${Math.ceil(v * 100)}%`)}
        />
    </eventbox>
}

function Music() {
    const mpris = Mpris.get_default()

    const viewLoop = (loop_status: AstalMpris.Loop) => {
        if (loop_status === AstalMpris.Loop.TRACK) return "󰑘 ";
        if (loop_status === AstalMpris.Loop.PLAYLIST) return "󰑖 ";
        return ""
    }

    const toggleloop = (loop_status: AstalMpris.Loop) => {
        if (loop_status === AstalMpris.Loop.UNSUPPORTED) return AstalMpris.Loop.UNSUPPORTED
        if (loop_status === AstalMpris.Loop.TRACK) return AstalMpris.Loop.NONE
        if (loop_status === AstalMpris.Loop.PLAYLIST) return AstalMpris.Loop.TRACK
        return AstalMpris.Loop.PLAYLIST
    }

    return <box>
        {bind(mpris, "players").as(ps => ps.slice(0, 1).map(p => {
            const loop = bind(p, "loop_status").as(v => viewLoop(v))
            const pbstatus = bind(p, "playback_status").as(v => v === AstalMpris.PlaybackStatus.PLAYING ? " " : " ")
            const title = Variable.derive([bind(p, "title"), bind(p, "artist")], (t, a) => t + " - " + a)
            return <eventbox
            cursor="pointer"
                className={bind(p, "playback_status").as(pbs => `music ${pbs === AstalMpris.PlaybackStatus.PLAYING ? "purple" : "orange"}`)}
                onClick={(_, e) => e.button === Astal.MouseButton.PRIMARY ? p.play_pause() : p.set_loop_status(toggleloop(p.loop_status))}
                onScroll={(_, e) => e.delta_y < 0 ? p.next() : p.previous()}
            >
                <box>
                    <label label={loop} />
                    <label label={pbstatus} />
                    <label label={bind(title)} truncate />
                </box>
            </eventbox >
        }

        ))}
    </box>
}

function Workspaces() {

    const dispatch = (ws: string) => hyprland.dispatch("workspace", ws);
    const occupied = Variable.derive([bind(hyprland, "clients"), bind(hyprland, "workspaces"), bind(hyprland, "focusedWorkspace")],
        (cls, wss, _) => (i: number) => cls.some(c => c.workspace.id === i) || wss.find(ws => ws.id === i)?.clients.length! > 0)

    return <eventbox className="workspaces">
        <box>
            {Array.from({ length: 9 }, (_, i) => i + 1).map(i => (
                <eventbox
                  onClick={() => dispatch(String(i))}
                  cursor="pointer"
                >
                    <box className={bind(hyprland, "focusedWorkspace")
                        .as(active => active.id == i ? "workspace-entry current" : "workspace-entry")}>
                        <label
                            label={bind(occupied)
                                .as(occ => occ(i) ? " ◆ " : " ◇ ")}
                            className="workspace"
                        />
                        <label
                            label={i == 3 || i == 6 ? " | " : "  "}
                            className="separator"
                        />
                    </box>
                </eventbox>
            ))}
        </box>
    </eventbox>
}

// --- Systray --- //

function SysTray() {
    const tray = Tray.get_default()

    return <box>
        {bind(tray, "items").as((items) =>
            items
                .filter((item) => item.gicon)
                .map((item) => (
                    <menubutton
                        className="systray-icon"
                        tooltipMarkup={bind(item, "tooltipMarkup")}
                        usePopover={false}
                        actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
                        menuModel={bind(item, "menuModel")}
                        onButtonReleaseEvent={(self, event) => {
                            const [_, x, y] = event.get_root_coords();
                            const button = event.get_button()[1];
                            const { PRIMARY, SECONDARY } = Astal.MouseButton;
                            const { SOUTH, NORTH } = Gdk.Gravity;
                            if (button === PRIMARY) {
                                item.activate(x, y);
                            } else if (button === SECONDARY) {
                                self.get_popup()?.popup_at_widget(self, SOUTH, NORTH, event);
                            }
                            return true;
                        }}
                    >
                        <icon gicon={bind(item, "gicon")} />
                    </menubutton>
                )),
        )}
    </box>
}

const asId = (model: string) => {
    for (const monitor of hyprland.monitors) {
        if (monitor.model === model) return monitor.id;
    }
    return ""
}

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    return <window
        className="bar"
        name={`bar-${asId(monitor.model)}`}
        setup={self => App.add_window(self)}
        gdkmonitor={monitor}
        namespace={'bar'}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}>
        <centerbox>
            <box halign={Gtk.Align.START} className="bar-area">
                <Workspaces />
            </box>
            <box halign={Gtk.Align.CENTER} className="bar-area">
                <Recording />
                <Time />
            </box>
            <box halign={Gtk.Align.END} className="bar-area">
                <Music />
                <Audio />
                <SysTray />
            </box>
        </centerbox>
    </window>

}
