export default function Chiste(props) {

    return (
        <div>
            <h2>{props.chiste}</h2>
            <p>{props.punchline}</p>
            {props.img && <img src={props.img}/>}
            <hr/>
        </div>
    )
}