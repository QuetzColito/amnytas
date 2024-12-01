// ----- Time ----- //

const date = Variable('', {
    poll: [1000, "date +'%a   %d %b   %H:%M'"]
});

export const Time = () => Widget.Label({ label: date.bind(), "class-name": "orange" });

// ----- Clock ----- //

const hours = Variable('', {
    poll: [1000, "date +%H"]
});
const minutes = Variable('', {
    poll: [1000, "date +%M"]
});
const seconds = Variable('', {
    poll: [1000, "date +%S"]
});
export const Clock = Widget.Box({
    class_name: "clock-widget",
    vpack: "fill",
    homogeneous: true,
    vexpand: true,
    hexpand: false,
    children: [
        Widget.Label({ label: hours.bind(), class_name: "hours" }),
        Widget.Label({ label: minutes.bind(), class_name: "minutes" }),
        Widget.Label({ label: seconds.bind(), class_name: "seconds" }),
    ]
})

// ----- Calendar ----- //

export const Calendar = Widget.Box({
    class_name: "calendar-widget",
    hexpand: true,
    children: [
        Widget.Calendar({
            vpack: "center",
            hexpand: true,
            showDayNames: true,
            showDetails: true,
            showHeading: true,
            showWeekNumbers: true,
        })
    ]
})
