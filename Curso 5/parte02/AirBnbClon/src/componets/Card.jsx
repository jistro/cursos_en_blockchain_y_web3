import "./Card.css";
export default function Card(props) {
    return (
        <div className="Card">
            <img 
                src= {`src/assets/img/${props.img}`}
                className="card__img"
            />
            <div className="card__stats">
                <img src="src/assets/img/star.png" className="card__star"/>
                <span className="card__rating">{props.rating}</span>
                <span className="card__reviews"> ({props.reviews}) </span>
                <span className="card__location"> {props.location} </span>
            </div>
            <p>{props.title}</p>
            <span><span className="card__price">${props.price}</span> / per person</span>
        </div>
    )
}