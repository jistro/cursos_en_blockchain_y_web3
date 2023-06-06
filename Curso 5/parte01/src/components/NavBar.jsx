import React from 'react'
import ReactDOM from 'react-dom/client'

export default function NavBar() {
    return (
        <nav>
            <img 
                src="./src/img/eth-diamond-rainbow.svg"
                alt="Ethereum logo"
                className='nav--logo'
            />
            <h3 className='nav--h3'>Web3</h3>
            <h4 className='nav--h4'>Curso de react - Proyecto 1</h4>
        </nav>
    )
}