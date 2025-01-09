import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar, { setRecording } from "./widget/Bar.jsx"
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
        if (request == "startRecording") {
            setRecording(true)
            res("started Recording")
        }
        if (request == "stopRecording") {
            setRecording(false)
            res("stopped Recording")
        }
        res("unknown command")
    },
})
