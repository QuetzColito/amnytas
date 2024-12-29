import { App } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
import Tray from "gi://AstalTray"
import Wp from "gi://AstalWp"
import AstalMpris from "gi://AstalMpris?version=0.1"

const hyprland = Hyprland.get_default()

function Time({ format = "%a   %d %b   %H:%M" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className="time"
        onDestroy={() => time.drop()}
        label={time()}
    />
}


function Audio() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    return <eventbox
        className="sound"
        onClick={(_, e) => {
            if (e.button === Astal.MouseButton.PRIMARY) {
                speaker.set_mute(!speaker.mute)
            } else {
                hyprland.message_async('dispatch exec pavucontrol', null)
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

    return <eventbox className="workspaces">
        <box>
            {Array.from({ length: 9 }, (_, i) => i + 1).map(i => (
                <eventbox onClick={() => dispatch(String(i))}>
                    <box className={bind(hyprland, "focusedWorkspace")
                        .as(active => active.id == i ? "workspace-entry current" : "workspace-entry")}>
                        <label
                            label={bind(hyprland, "workspaces")
                                .as(wss => wss.find(ws => ws.id === i)?.clients.length! > 0 ? " ◆ " : " ◇ ")}
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
        {bind(tray, "items").as(items => items.map(function(item: any) {
            if (item.iconThemePath)
                App.add_icons(item.iconThemePath)

            const menu = item.create_menu()

            return <button
                className="systray-icon"
                tooltipMarkup={bind(item, "tooltipMarkup")}
                onDestroy={() => menu?.destroy()}
                onClickRelease={self => {
                    menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
                }}>
                <icon gIcon={bind(item, "gicon")} />
            </button>
        }))}
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
        className="Bar"
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
