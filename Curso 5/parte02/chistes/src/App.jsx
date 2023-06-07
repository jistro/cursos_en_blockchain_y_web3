import { useState } from 'react'
import './App.css'
import Chiste from './components/Chiste'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Chiste 
        chiste="un hombre va al medico..." 
        punchline='pero doctor...'
        img="https://i.ytimg.com/vi/pVbtFP40E50/maxresdefault.jpg"
      />
      <Chiste
        chiste="Por qué las focas del circo miran siempre hacia arriba?"
        punchline="Porque es donde están los focos."
      />
      <Chiste
        chiste="Estas obsesionado con la comida"
        punchline="No se a que te refieres croquetamente"
      />
      <Chiste
        chiste="Hola, ¿está Agustín?"
        punchline="No, estoy incomodín."
      />
      <Chiste
        chiste="¿Sabes cómo se queda un mago después de comer?"
        punchline="Magordito."
      />
      <Chiste
        chiste="¿Por qué estás hablando con esas zapatillas?"
        punchline='Porque pone "Converse".'
      />
      
    </>
  )
}

export default App
