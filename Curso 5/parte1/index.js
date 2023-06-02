

const catinio = (
    <div>
        <h1>Mira este catinio</h1>
        <img 
        src="https://i.kym-cdn.com/entries/icons/original/000/026/489/crying.jpg" 
        alt="imagen" 
        width="400px"
        />
        <ul>
            <li>catinio 1</li>
            <li>catinio 2</li>
            <li>catinio 3
                <ul>
                    <li>catinio 3.1</li>
                    <li>catinio 3.2</li>
                </ul>
            </li>
        </ul>
    </div>
)
const navBarCatinio = (
    <nav>\
        <h1>cattttoooo</h1>
        <ul>
            <li>catinio 1</li>
            <li>catinio 2</li>
            <li>catinio 3</li>
        </ul>
    </nav>
)

const armyOfSpiderman = (
    <div>
        <h1>Army of Spiderman</h1>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
        <img src="https://i.kym-cdn.com/entries/icons/original/000/003/231/dancing-spiderman.gif"
        width="50px"/>
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
).render(catinio)
ReactDOM.createRoot(
    document.getElementById("navBar")
).render(navBarCatinio)    
ReactDOM.createRoot(
    document.getElementById("army")
).render(armyOfSpiderman)