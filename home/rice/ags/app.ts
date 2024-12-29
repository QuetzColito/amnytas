import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar.jsx"
import Widgets, { toggleDashboard } from "./widget/Dashboard.jsx"

App.start({
    css: style,
    main: () => {
        App.get_monitors().map(Bar)
        Widgets()
    },
    requestHandler(request: string, res: (response: any) => void) {
        if (request == "toggleDashboard") {
            toggleDashboard()
            res("toggled Dashboard")
        }
        res("unknown command")
    },
})
