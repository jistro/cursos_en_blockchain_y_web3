// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

contract Mappings{
    
    //Declaramos un mapping para elegir un numero
    mapping (address => uint) public elegirNumero;
    
    function ElegirNumero(uint _numero) public
    {
        elegirNumero[msg.sender] = _numero;
    }
    
    function consultarNumero() public view returns(uint)
    {
        return elegirNumero[msg.sender];
    }
    
    mapping (string => uint) cantidadDinero;
    
    function Dinero(string memory _nombre, uint _cantidad) public
    {
        cantidadDinero[_nombre] = _cantidad;
    }
    
    function consultarDinero(string memory _nombre) public view returns(uint)
    {
        return cantidadDinero[_nombre];
    }
    
    //Ejemplo de mapping con un tipo de dato complejo
    struct Persona{
        string nombre;
        uint edad;
    }
    
    mapping(address => Persona) personas;
    
    function inePersona(string memory _nombre, uint _edad) public
    {
        personas[msg.sender] = Persona(_nombre, _edad);
    }
    
    function VisualizarIne() public view returns(Persona memory)
    {
        return personas[msg.sender];
    }
}