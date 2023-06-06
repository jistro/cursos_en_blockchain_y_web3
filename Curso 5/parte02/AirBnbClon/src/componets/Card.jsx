import "./Card.css";
export default function Card() {
    return (
        <div className="Card">
            <img 
                src= "src/assets/img/katie-zaferes.png" 
                className="card__img"
            />
            <div className="card__stats">
                <img src="src/assets/img/star.png" className="card__star"/>
                <span className="card__rating">4.94</span>
                <span className="card__reviews"> (128) </span>
                <span className="card__location"> USA, Ohio</span>
            </div>
            <p>How to survive in Ohio with Katie Zaferes</p>
            <span><span className="card__price">$25</span> / per person</span>
        </div>
    )
}