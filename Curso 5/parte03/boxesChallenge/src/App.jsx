import './App.css'
import React from "react"
import boxes from "./boxes"
import Box from './components/box'

export default function App(props) {
    const [cubes, setCubes] = React.useState(boxes)

    function toggle(id) {
      setCubes(prevCubes => {
        const newCubes = []
        for (let i = 0; i < prevCubes.length; i++) {
          const currentCube = prevCubes[i]
          if (currentCube.id === id) {
            const updatedCube = {...currentCube, on: !currentCube.on}
            newCubes.push(updatedCube)
          } else {
            newCubes.push(currentCube)
          }
        }
        return newCubes
      })
    }

    const cubeElements = cubes.map(cube => (
      <Box 
        key={cube.id} 
        id ={cube.id} 
        on={cube.on} 
        setClick={toggle}
      />
    ))
    return (
        <main>
            {cubeElements}
        </main>
    )
}
