// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0<0.7.0;

contract Banco 
{
    struct cliente
    {
        string nombre;
        address wallet;
        uint dinero;
    }
    //relaciona el nombre de clientes con el tipo de dato cliente
    mapping (string => cliente) clientes;

    /*
    permite dar de alta a un nuevo cliente
    lo ponemos intrenal porque no nos interesa que en la interfaz
    grafica aparezca esta funcion
    */
    function nuevo_cliente(string memory _nombre) internal 
    {
        clientes[_nombre]=cliente(_nombre,msg.sender,0);
    }
}