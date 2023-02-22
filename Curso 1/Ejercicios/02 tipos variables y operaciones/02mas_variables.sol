
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;

contract variables 
{
    string caaracteres;
    string public saludo = "hola mundo";
    string vacio = "";

    bool public flagT = true;
    bool flagF = false;

    bytes32 hay32Bites;
    byte unoSolo;
    bytes32 public hash = keccak256( abi.encodePacked(saludo) );
    bytes4 public identificador;

    function ejemplosBytes4() public 
    {
        identificador = msg.sig;
    }

    address direccion;
    address public direccionLocal_0 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public direccionLocal_1 = 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB;

}