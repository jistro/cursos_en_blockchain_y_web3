import "./Hero.css"
import experiencesImage from '../assets/img/photo-grid.png';

export default function Hero() {

    return (
        <section className="hero">
            <div className="container__img">
                <img 
                    src={experiencesImage} 
                    alt="experiences" 
                    className="hero__image"
                />
            </div>
            <div className="hero__text">
                <h1 className="h1__hero">Online Experiences</h1>
                <p className="p__hero">Join unique interactive activities led by one-of-a-kind hosts—all without leaving home.</p>
            </div>
        </section>
        
            
    )

}