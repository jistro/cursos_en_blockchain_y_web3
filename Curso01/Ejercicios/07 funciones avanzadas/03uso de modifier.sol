// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0<0.7.0;

contract Modifier
{
    //ejemplo de que el propietario puede ejecutar esa funcion

    address public owner;

    constructor() public 
    {
        owner = msg.sender;
    }

    modifier soloPropietario()
    {
        require(msg.sender==owner, "no hay permisos para ejecutar la funcion");
        _;
    }

    function ejemplo1() view  public soloPropietario() returns (string memory)
    {
        return "bienvenido creador";
    }


    struct cliente
    {
        address direccionCliente;
        string nombreCliente;
    }

    mapping(string=>address) clientes;

    function altaCliente(string memory _nombre) public
    {
        clientes[_nombre]=msg.sender;
    }

    modifier soloClientes(string memory _nombre)
    {
        require(clientes[_nombre] == msg.sender);
        _;
    }

    function ejemplo2(string memory _nombre) view public soloClientes(_nombre) returns (string memory)
    {
        return "bienvenido cliente";
    }


}