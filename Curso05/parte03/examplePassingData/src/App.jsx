import React from 'react'
import './App.css'
import Header from './components/Header'
import Body from './components/Body'

function App() {

  const [user, setUser] = React.useState("Joe")

  return (
    <>
        <Header user={user}/>
        <Body user={user}/>
    </>
  )
}

export default App
