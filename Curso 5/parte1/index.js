ReactDOM.render(
    <h1>Mira este catinio</h1>
,document.getElementById("root"))
ReactDOM.render(
    <img 
        src="https://i.kym-cdn.com/entries/icons/original/000/026/489/crying.jpg" 
        alt="imagen" 
        width="400px"
        />
,document.getElementById("root2"))
ReactDOM.render(
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
,document.getElementById("lista"))