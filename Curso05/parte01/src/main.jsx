import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'



export default function Main() {

  return (
    <main>
      <h1 className='main--title'>Porque aprender web 3</h1>
      <ul className='main--why'>
        <li>Es el futuro</li>
        <li>Es divertido</li>
        <li>Es rentable</li>
      </ul>
      <p>y la mas importante</p>
      <img src='src/img/meme.jpg' 
            height={120}
            />
    </main>
  )
}