import './FormText.css'
export default function FormText(){
    return(
        <main className='main--form'>
            <form className='form'>
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
                <button className='form--buttom'>Get a new meme image 🖼</button>
            </form>
        </main>
    )
}