const navBar = (
    <nav>
        <img 
            src="https://ethereum.org/static/c48a5f760c34dfadcf05a208dab137cc/d1ef9/eth-diamond-rainbow.png"
            width="50px"
            />
    </nav>
)

const root = (
    <div>
        <h1>Fun Facts de Ethereum</h1>
        <ul>
            <li>El nombre es un homenaje a la sustancia etérea que llena el universo en la mitología griega.</li>
            <li>El logo es un diamante con un arcoiris.</li>
            <li>El creador es Vitalik Buterin, un ruso-canadiense de 27 años.</li>
            <li>El primer bloque se minó el 30 de julio de 2015.</li>
        </ul>
    </div>
)

/*
ReactDOM.render(
    navBarCatinio,
document.getElementById("navBar"))
ReactDOM.render(
    catinio,
document.getElementById("root"))
ReactDOM.render(
    armyOfSpiderman,
document.getElementById("army"))
*/

ReactDOM.createRoot(
    document.getElementById("root")
).render(root)
ReactDOM.createRoot(
    document.getElementById("navBar")
).render(navBar)