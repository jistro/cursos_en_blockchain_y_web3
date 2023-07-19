import { useState } from 'react'
import './App.css'
import Header from './components/Header'
import Meme from './components/Meme'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Header/>
      <Meme/>
    </>
  )
}

export default App
