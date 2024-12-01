import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar.jsx"
import Widgets from "./widget/Dashboard.jsx"

App.start({
    css: style,
    main: () => {
        App.get_monitors().map(Bar)
        Widgets()
    }
})
