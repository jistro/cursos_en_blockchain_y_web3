import './Header.css'

export default function Header() {
    return(
        <header className="header">
            <img src="https://upload.wikimedia.org/wikipedia/en/9/9a/Trollface_non-free.png"
                alt="Problem?"
                className='header--img'
            />
            <h2 className='header--title'>Meme Generator</h2>
            <h4 className='header--proyect'>parte 3</h4>
        </header>
    )
}