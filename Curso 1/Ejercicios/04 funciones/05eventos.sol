// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;

contract eventos
{
    //Declaramos los eventos
    event nombreEvento1 (string eventoNombreDePersona);
    event nombreEvento2 (string eventoNombreDePersona, uint eventoEdadPersona);
    event nombreEvento3 (string , uint, address, bytes32);
    event abortarMision ();
    function emitir_evento1(string memory NOMBRE_DE_PERSONA) public 
    {
        emit nombreEvento1(NOMBRE_DE_PERSONA);
    }
    function emitirEvento2(string memory NOMBRE_DE_PERSONA, uint EDAD) public
    {
        emit nombreEvento2(NOMBRE_DE_PERSONA, EDAD);
    }
    function emitirEvento3(string memory NOMBRE_PERSONA, uint EDAD) public 
    {   
        address wallet = msg.sender;
        bytes32 hashId = keccak256(abi.encodePacked(NOMBRE_PERSONA,EDAD,wallet));
        emit nombreEvento3(NOMBRE_PERSONA, EDAD, msg.sender ,hashId);
    }
    function abortar_Mision() public 
    {
        emit abortarMision();
    }
}