// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.0 < 0.7.0;
pragma experimental ABIEncoderV2;

contract usoRequire
{
    function verificar_pass(string memory _pass) public pure returns (string memory)
    {
        require( (keccak256( bytes(_pass) ) == keccak256( bytes( "123" ))), "contraseña incorrecta" );
        return "bienvenido";
    }

    // funcion que nos permita pagar 

    uint public tarjeta = 0;
    uint horaIngreso = 0;
    function pago(uint _dinero) public returns(string memory, uint)
    {
        require(now > ( horaIngreso + (5 seconds) ), "se solcito hace 5 segundos. Cancelando" );
        tarjeta += _dinero;
        horaIngreso = now;
        return ("se deposito a la tarjeta", tarjeta);
    }
}