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

contract Cliente is Banco 
{

    function alta_cliente(string memory _nombre) public 
    {
        nuevo_cliente(_nombre);
    }

    function deposito_dinero(string memory _nombre, uint _dineroDeposito) public 
    {
        clientes[_nombre].dinero += _dineroDeposito; 
    }

    function retiro_dinero(string memory _nombre, uint _dineroRetiro) public returns (bool)
    {
        if (_dineroRetiro <= clientes[_nombre].dinero)
        {
            clientes[_nombre].dinero -= _dineroRetiro;
            return true;
        }
        else 
        {
            return false;
        }
    }

    function consulta_dinero(string memory _nombre) public view returns (uint)
    {
        return clientes[_nombre].dinero;
    }
}