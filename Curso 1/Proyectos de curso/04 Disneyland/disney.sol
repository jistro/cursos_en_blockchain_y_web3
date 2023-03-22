// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";

contract Disney {
//---------------------------Declaraciones Iniciales--------------------------------------//

    // instancia del contrato token
    ERC20Disney private tokensDisney;

    // direccion de disney (owner)
    address payable public owner;


    // constructor
    constructor(){
        tokensDisney = new ERC20Disney(1000);
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
        payable(msg.sender).transfer(returnValue);

        // obtencion del num. de tokens disponible
        uint Balance = balanceOf();
        require(_numTokens <= Balance, "Lo sentimos, no hay disponible mas de la cantidad que pidio");

        // se transfiere el num. de tokens solicitados al cliente
        tokensDisney.transfer(msg.sender, _numTokens);

        // registero de tokens comprados
        Clientes[msg.sender].tokensComprados = _numTokens;

    }

    // balance de tokens del contrato
    function balanceOf() public view returns(uint){
        return tokensDisney.balanceOf(address(this));
    } 

    // visualizar el num de tokens de un cliente

    function misDisneyDollars() public view returns(uint){
        return tokensDisney.balanceOf(msg.sender);
    }

    // funcion para generar mas tokens

    function mintMoreTokens(uint _numTokens) public Unicamente(msg.sender){
        tokensDisney.mint(msg.sender,_numTokens);
    } 

    // modificador para permitir el acceso solo al que lanza el contrato (disney)
    modifier Unicamente(address _direccion){
        require(_direccion == owner, "NO tienes permisos para ejecutar");
        _;
    }
    


//----------------------------------------------------------------------------------------//

}

