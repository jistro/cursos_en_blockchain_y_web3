import React from "react"
import WindowTracker from "./WindowTracker"

export default function App() {
    
    const [show, setShow] = React.useState(true)

    function toggleWindowTracker() {
        setShow(prevShow => !prevShow)
    }

    return (
        <div className="container">
            <button onClick={toggleWindowTracker}>
                Toggle WindowTracker
            </button>
            {show && <WindowTracker />}
        </div>
    )
}
