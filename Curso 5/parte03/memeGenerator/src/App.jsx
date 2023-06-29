import { useState } from 'react'
import './App.css'
import Header from './components/Header'
import FormText from './components/FormText'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Header/>
      <FormText/>
    </>
  )
}

export default App
