// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;

contract modificadoresVariables 
{
    uint    public  enteroPublico = 23;
    string  public  saludoPublico = "Hola!!";
    address public  owner;

    constructor() public 
    {
        owner = msg.sender;
    }

    uint private enteroPrivado = 10;
    bool private flagPrivate   = true;

    function testPrivate(uint _test) public  
    {
        enteroPrivado = _test;
    }

    bytes32 internal hash               = keccak256( abi.encodePacked("hola") );
    address internal direccionInternal  = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

}