import React from 'react'
import './Meme.css'
import '../memesData.jsx'
import memesData from '../memesData.jsx'
export default function Meme(){
    
    const [memeData, setMemeData] = React.useState({
        topText:"", 
        bottomText:"",
        meme:"http://i.imgflip.com/1bij.jpg"
    })

    const [allMemeImgs, setAllMemeImgs] = React.useState(memesData)

    function getMemeImg(){
        const memeArray = allMemeImgs.data.memes
        const memeIndex = Math.floor(Math.random() * memeArray.length)
        const url = memeArray[memeIndex].url
        //const url = memeArray[memeIndex].url
        //console.log(url)
        setMemeData(prevMemeData => ({
            ...prevMemeData,
            meme: url
        }))
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
                    src={memeData.meme}
                    alt='meme'
                    className='meme--img'
                />
            </div>
        </main>
    )
}