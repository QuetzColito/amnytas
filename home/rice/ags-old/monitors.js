// ----- Monitors ----- //

const battery = await Service.import('battery')
const round = (x) => Math.round(x * 100)
const divide = ([total, free]) => round(free / total)
const trim = (str) => str.substring(0, str.length - 1);

const cpu = Variable(0, {
    poll: [2000, 'top -b -n 1', out => divide([100, out.split('\n')
        .find(line => line.includes('Cpu(s)'))
        .split(/\s+/)[1]
        .replace(',', '.')])],
})

const ram = Variable(0, {
    poll: [2000, 'free', out => divide(out.split('\n')
        .find(line => line.includes('Mem:'))
        .split(/\s+/)
        .splice(1, 2))],
})

const storage1 = Variable(0, {
    poll: [2000, 'df', out => trim(out.split('\n')
        .map(line => line.split(/\s+/))
        .find(line => line[5] === "/")
        .splice(4, 1)[0])],
})

const storage2 = Variable(0, {
    poll: [2000, 'df', out => trim(out.split('\n')
        .map(line => line.split(/\s+/))
        .find(line => line[5].includes('/storage'))
        .splice(4, 1)[0])],
})

const Monitor = (color, value, icon) => Widget.Box({
    hpack: "center",
    vertical: true,
    class_name: `${color} monitor`,
    children: [
        Widget.Box({
            homogeneous: true,
            class_name: "stats",
            children: [
                Widget.Label({ label: value.bind().as(p => `${p}%`) }),
                Widget.Label({ label: icon, class_name: "icon" }),
            ]
        }),
        Widget.ProgressBar({
            widthRequest: 40,
            value: value.bind().as(p => p/100)
        })
    ]
})

export const Monitors = Widget.Box({
    class_name: "monitors",
    homogeneous: true,
    children: [
        Monitor("cyan", cpu, " "),
        Monitor("blue", ram, " "),
        Monitor("purple", storage1, " "),
        battery.available
            ? Monitor("green", battery.percent, battery.bind("charging").as(ch => ch ? "󱐥" : "󱐤"))
            : Monitor("green", storage2, " "),
    ]
})
