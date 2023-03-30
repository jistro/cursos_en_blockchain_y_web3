// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract loteria{
    //-----------------------------------variables-----------------------------------//

    // instancia del contrato token
    Fichas private tokensLoteria;
    // direccioes de owner y contrato
    address public owner;
    address public contrato;
    // cantidad de tokens creados
    uint256 public tokens_creados = 1000;

    constructor() {
        // asignacion de owner y contrato
        owner = msg.sender;
        contrato = address(this);
        // creacion del token ERC20 con la cantidad de tokens creados
        tokensLoteria = new Fichas(tokens_creados);
    }

    event compraTokens (address, uint);    
    
    // funcion para establecer precio de un token
    function precioTokens(uint _numTokens) internal pure returns(uint){
        return _numTokens * 1 ether;
    }

    //modificador para solo el owner pueda hacer la funcion
    modifier soloOwner(){
        require(msg.sender == owner, "Solo el owner puede hacer esto");
        _;
    }

    function mintMoreTokens(uint _numTokens) public soloOwner{
        tokensLoteria.mint(_numTokens);
    } 

    function comprarTokens(uint _numTokens) public payable{
        // Establecer precio de tokens
        uint coste = precioTokens(_numTokens);

        // se evalua el dinero que el cliente paga por los tokens
        require(msg.value >= coste, "No se puede comprar esta cantidad, compra menos o usa mas ETH");

        // diferencia de lo que el cliente paga
        uint returnValue = msg.value - coste;

        // se envia la diferencia de ETH al owner
        payable(msg.sender).transfer(returnValue);

        //se obtiene el balance actual del contrato
        uint balance = tokensDispobibles();

        // se evalua si el contrato tiene suficientes tokens para vender
        require(balance >= _numTokens, "No hay suficientes tokens disponibles");

        // se envian los tokens al cliente
        tokensLoteria.transfer(msg.sender, _numTokens);

        emit compraTokens(msg.sender, _numTokens);
    }

    // funcion para obtener el balance del contrato
    function tokensDispobibles() public view returns(uint){
        return tokensLoteria.balanceOf(address(this));
    }

    // obtener el balance de tokens acomulados en el bote
    function Bote() public view returns(uint) {
        return tokensLoteria.balanceOf(owner);
    }


    function MisTokens() public view returns(uint){
        return tokensLoteria.balanceOf(msg.sender);
    }

    //-----------------------------------Loteria-----------------------------------//
    
    // precio del boleto 
    uint public PrecioBoleto = 5;
    // Relacion entre la persona que compra los boletos y los numeros de los boletos
    mapping (address => uint[]) idPersonaBoletos;
    // relacion nesesaria para identificar al ganador
    mapping (uint => address) boletoGanador;
    // num aleatorio
    uint RandNace= 0;
    // boletos generados
    uint[] boletosComprados;
    // eventos
    event event_boletoComprado(uint); // evento de compra de bolero
    event event_boletoGanador(uint); // evento ganador
    event event_tokensDevueltos(uint); // evento de devolucion de tokens

    //funcion para comprar boleros de loteria
    function CompraBoleto(uint _boletos) public{
        uint precioTotal = _boletos*PrecioBoleto;
        require(precioTotal<=MisTokens(), "Nesecitas comprar mas tokens");
        // transferencia de tiokens akl owner -> bote
        tokensLoteria.transferFromUser(msg.sender,precioTotal);
        // generacion de boletos
        for(uint i=0; i<_boletos; i++)
        {
            // generacion de boleto
            // se usa keccak256 para generar un numero aleatorio
            // se usa abi.encodePacked para concatenar los datos
            // se usa uint para convertir el numero a uint
            uint boleto = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, i)));
            boletosComprados.push(boleto);
            idPersonaBoletos[msg.sender].push(boleto);
            emit event_boletoComprado(boleto);
        }
    }

    // funcion para ver los boletos que tiene el usuario
    function MisBoletos() public view returns(uint[] memory){
        return idPersonaBoletos[msg.sender];
    }

    // funcion para generar el ganador
    function Ganador() public soloOwner{
        // se evalua si hay boletos comprados
        require(boletosComprados.length>0, "No hay boletos comprados");
        // declaracion de la longitud del array
        uint longitud = boletosComprados.length;
        // generacion de un numero aleatorio entre 0 y la longitud del array
        uint posArray = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, longitud))) % longitud;
        // se obtiene el numero del boleto ganador
        uint eleccion = boletosComprados[posArray];
        // se obtiene la direccion del ganador
        address ganador = idPersonaBoletos[boletoGanador[eleccion]][0];
        // emit del evento ganador
        emit event_boletoGanador(eleccion);
        // se envian los tokens al ganador
        tokensLoteria.transfer(ganador, Bote());
    }

    function devolverTokens(uint _numTokens) public payable{
        // se evalua si no puso negativo
        require(_numTokens>0, "No puedes devolver tokens negativos");
        // se evalua si el cliente tiene suficientes tokens para devolver
        require(_numTokens<=MisTokens(), "No tienes suficientes tokens para devolver");
        // se envian los tokens al owner
        tokensLoteria.transferFromUser(msg.sender, _numTokens);
        // se envia los eth al cliente
        payable(msg.sender).transfer(_numTokens);
        // emit del evento de devolucion de tokens
        emit event_tokensDevueltos(_numTokens);
    }
}