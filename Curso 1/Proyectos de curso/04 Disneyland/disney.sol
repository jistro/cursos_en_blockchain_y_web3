// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";

contract Disney {
//---------------------------Declaraciones Iniciales--------------------------------------//

    // instancia del contrato token
    ERC20Disney private token;

    // direccion de disney (owner)
    address payable public owner;

    // constructor
    constructor() public{
        token = new ERC20Disney(1000);
        owner = payable(msg.sender);
    }

    // estructura de datos para almacenar a los clientes de Disney
    struct cliente {
        uint tokensComprados;
        string [] atraccionesDisfrutadas;
    }

    // mapping para el registro de clientes
    mapping (address => cliente) public Clientes;
//----------------------------------------------------------------------------------------//

//---------------------------------Gestion de tokens--------------------------------------//

    // funcion para establecer precio de un token 
    function PrecioTokens(uint _numTokens) internal pure returns(uint) {
        // convercion 1:1 de tokens <=> eth
        return _numTokens * (1 ether);
    }

    // compra de tokens para uso de atracciones
    function compraTokens(uint _numTokens) public payable {
        // Establecer precio de tokens 
        uint coste = PrecioTokens(_numTokens);

        // se evalua el dinero que el cliente paga por los tokens
        require(msg.value >= coste, "No se puede comprar esta cantidad, compra menos o usa mas ETH");

        // diferencia de lo que el cliente paga
        uint returnValue = msg.value - coste;

        // disney retorna la cantidad de ETH al cliente
        msg.sender.transfer(returnValue);

        // obtencion del num. de tokens disponible
        uint Balance = token.balanceOf(owner);
        require(_numTokens <= Balance, "Lo sentimos, no hay disponible mas de la cantidad que pidio");

        // se transfiere el num. de tokens solicitados al cliente
        token.transfer(msg.sender, _numTokens);

        // registero de tokens comprados
        Clientes[msg.sender].tokensComprados = _numTokens;

    }

//----------------------------------------------------------------------------------------//



}