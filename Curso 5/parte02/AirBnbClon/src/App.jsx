import { useState } from 'react'
import './App.css'
import NavBar from './componets/NavBar'
import Hero from './componets/Hero'
import Card from './componets/Card'
function App() {

  return (
    <>
      <NavBar />
      <Hero/>
      <Card 
      img = "katie-zaferes.png"
      title = "How to survive in Ohio with Katie Zaferes"
      price = "25.50"
      rating = "4.94"
      reviews = "25"
      location = "Ohio, USA"
      />
    </>
  )
}

export default App
