import React from "react"

export default function Chiste(props) {
    const [mostrar, setMostrar] = React.useState(false)

    function toggleMostrar() {
        setMostrar(prevMostrar => !prevMostrar)
    }

    return (
        <div>
            <h2>{props.chiste}</h2>
                <p>{props.img && <img src={props.img}/>}</p>
                <p>{mostrar && props.punchline }</p>
                <button onClick={toggleMostrar}>{mostrar ? "Ocultar" : "Mostrar"} Punchline</button>
                <p> {props.chistosometro}/10 {props.chistoso ? "Chistoso" : "Aburrido"}</p>
            <hr/>
        </div>
    )
}