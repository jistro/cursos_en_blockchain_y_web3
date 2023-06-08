const Web3 = require("web3");
const Tx = require("ethereumjs-tx").Transaction;
const fetch = require("node-fetch");

// Importar el archivo JSON del contrato
const contractJSON = require("../build/contracts/OracleNasa.json");

// Instancia de Web3
const web3 = new Web3('ws://127.0.0.1:8545');

// Direcciones del contrato y la cuenta
const contractAddress = "0xC87012af8baB91f67C8C0E91394bd62eAAB13a5D";
const contractInstance = new web3.eth.Contract(contractJSON.abi, contractAddress);
const privateKey = Buffer.from("0x55f57e9a62970ecd336181d9f5607ea45ba1a619b40595414fd9abc86fb911d2", 'hex');
const address = "0x38B05fE8123BaE30BF9Fb8B654F7811b5b7f93d7";

// Obtener el número de bloque
async function getLatestBlockNumber() {
    try {
        const latestBlockNumber = await web3.eth.getBlockNumber();
        const lastBlockNumber = latestBlockNumber - 1;
        listenEvent(lastBlockNumber);
    } catch (error) {
        console.error('Error al obtener el número de bloque:', error);
    }
}

// Función: listenEvent()
function listenEvent(lastBlock) {
    contractInstance.events.__callbackNewData({}, { fromBlock: lastBlock, toBlock: 'latest' })
        .on('data', updateData)
        .on('error', console.error);
}

// Función: updateData()
function updateData(event) {
    console.log('Nuevo evento:', event);
    fetchDataAndSetDataContract();
}

// Función: fetchDataAndSetDataContract()
async function fetchDataAndSetDataContract() {
    try {
        const url = 'https://api.nasa.gov/neo/rest/v1/feed?start_date=2023-01-01&end_date=2023-01-08&api_key=PTTMcKLkxP0Py2vG89XKO7z3JVrXWqfxZFIjGbBL';
        const response = await fetch(url);
        const json = await response.json();
        const value = json.element_count;
        await setDataContract(value);
    } catch (error) {
        console.error('Error al obtener los datos:', error);
    }
}

// Función: setDataContract()
async function setDataContract(value) {
    try {
        const txCount = await web3.eth.getTransactionCount(address);
        const gasAmount = await contractInstance.methods.setNumAsteroides(value).estimateGas({});
        const rawTx = {
            nonce: web3.utils.toHex(txCount),
            gasPrice: web3.utils.toHex(web3.utils.toWei("2", "gwei")),
            gasLimit: web3.utils.toHex(gasAmount),
            to: contractAddress,
            value: '0x00',
            data: contractInstance.methods.setNumAsteroides(value).encodeABI()
        };

        const tx = new Tx(rawTx);
        tx.sign(privateKey);
        const serializedTx = tx.serialize().toString('hex');
        await web3.eth.sendSignedTransaction('0x' + serializedTx);
    } catch (error) {
        console.error('Error al establecer los datos en el contrato:', error);
    }
}

// Llamar a la función para obtener el número de bloque y comenzar a escuchar eventos
getLatestBlockNumber();
