// ----- Tray ----- //

const systemtray = await Service.import('systemtray')

const SysTrayItem = item => Widget.EventBox({
    child: Widget.Icon({size: 23}).bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
});

export const SysTray = () => Widget.Box({
    children: systemtray.bind('items').as(i => i.map(SysTrayItem))
})
