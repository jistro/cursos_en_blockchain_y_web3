import { useState } from 'react'
import './App.css'
import NavBar from './componets/NavBar'
import Hero from './componets/Hero'
import Card from './componets/Card'
import data from './data'
function App() {

  const cardElements = data.map(card => {
    return  <Card
              key = {card.id}
              item = {card}
            />
  })

  return (
    <>
      <NavBar />
      <Hero/>
      <section className="cards">
        {cardElements}
      </section>
    </>
  )
}

export default App
