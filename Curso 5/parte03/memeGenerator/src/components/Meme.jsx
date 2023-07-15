import React from 'react'

export default function Meme(){
    
    const [memeData, setMemeData] = React.useState({
        topText:"", 
        bottomText:"",
        meme:"http://i.imgflip.com/1bij.jpg"
    })

    const [allMemes, setAllMemes] = React.useState([])

    function handleChange(event) {
        const{name, value} = event.target
            setMemeData(prevMemeData=> {
                return {
                    ...prevMemeData,
                    [name]: value
                }
        })
    }

    React.useEffect(async() => {
        const res = await fetch("https://api.imgflip.com/get_memes")
        const data = await res.json()
        setAllMemes(data.data.memes)
    }, [])
    
    function getMemeImage() {
        const randomNumber = Math.floor(Math.random() * allMemes.length)
        const url = allMemes[randomNumber].url
        console.log(url)
        setMemeData(prevMeme => ({
            ...prevMeme,
            meme: url
        }))
        
    }

    return(
        <main>
            <div className='form'>
                <input 
                    type='text' 
                    placeholder='Top text'
                    className="form--input"
                    onChange={handleChange}
                    value={memeData.topText}
                    name='topText'
                />
                <input 
                    type='text' 
                    placeholder='Bottom text'
                    className="form--input"
                    onChange={handleChange}
                    value={memeData.bottomText}
                    name='bottomText'
                />
                <button 
                    className='form--buttom'
                    onClick={getMemeImage}
                >
                    Get a new meme image 🖼
                </button>

                <div className="meme">
                    <img src={memeData.meme} className="meme--image" />
                    <h2 className="meme--text top">{memeData.topText}</h2>
                    <h2 className="meme--text bottom">{memeData.bottomText}</h2>
                </div>
            </div>
        </main>
    )
}