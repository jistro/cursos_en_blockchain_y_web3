import React from 'react'
import './Meme.css'
import '../memesData.jsx'
import memesData from '../memesData.jsx'
export default function Meme(){
    
    const [memeImage, setMemeImage] = React.useState("")

    function getMemeImg(){
        const memeArray = memesData.data.memes
        const memeIndex = Math.floor(Math.random() * memeArray.length)
        //const url = memeArray[memeIndex].url
        //console.log(url)
        setMemeImage(memeArray[memeIndex].url)
    }

    return(
        <main className='main--form'>
            <div className='form'>
                <input 
                    type='text' 
                    placeholder='Top text'
                    className="form--input"
                />
                <input 
                    type='text' 
                    placeholder='Bottom text'
                    className="form--input"
                />
                <button 
                    className='form--buttom'
                    onClick={getMemeImg}
                >
                    Get a new meme image 🖼
                </button>
                <img
                    src={memeImage}
                    alt='meme'
                    className='meme--img'
                />
            </div>
        </main>
    )
}