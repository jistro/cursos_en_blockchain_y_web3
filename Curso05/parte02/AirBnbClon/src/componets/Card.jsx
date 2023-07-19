import "./Card.css";
export default function Card(props) {
    let badgeText
    if (props.item.openSpots == 0) {
        badgeText = "Sold out"

    } else if (props.item.location == "Online") {
        badgeText = "Online"
    }
    return (
        <div className="Card">
        {badgeText && <div className="card__badge">{badgeText}</div>}
            <img 
                src= {`src/assets/img/${props.item.coverImg}`}
                className="card__img"
            />
            <div className="card__stats">
                <img src="src/assets/img/star.png" className="card__star"/>
                <span className="card__rating">{props.item.stats.rating}</span>
                <span className="card__reviews"> ({props.item.stats.reviewCount}) </span>
                <span className="card__location"> {props.item.location} </span>
            </div>
            <p className="card__title">{props.item.title}</p>
            <p className="card__description">{props.item.description}</p>
            <span><span className="card__price">${props.item.price}</span> / per person</span>
        </div>
    )
}