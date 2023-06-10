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
        chistoso={true}
        chistosometro={10}
      />
      <Chiste
        chiste="Por qué las focas del circo miran siempre hacia arriba?"
        punchline="Porque es donde están los focos."
        chistoso={false}
        chistosometro={5}
      />
      <Chiste
        chiste="Estas obsesionado con la comida"
        punchline="No se a que te refieres croquetamente"
        chistoso={true}
        chistosometro={8}
      />
      <Chiste
        chiste="Hola, ¿está Agustín?"
        punchline="No, estoy incomodín."
        chistoso={false}
        chistosometro={3}
      />
      <Chiste
        chiste="¿Sabes cómo se queda un mago después de comer?"
        punchline="Magordito."
        chistoso={true}
        chistosometro={7}
      />
      <Chiste
        chiste="¿Por qué estás hablando con esas zapatillas?"
        punchline='Porque pone "Converse".'
        chistoso={false}
        chistosometro={2}
      />
      
    </>
  )
}

export default App
