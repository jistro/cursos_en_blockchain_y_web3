

pragma solidity >=0.4.0 <0.7.0;

import "./ERC20.sol"
/*importamos el contrato ERC20 
usamos openzeppelin pero para este caso practico usaremos el documento*/

contract conceptosBasicos
{
    address owner; //DIRECCION DE LA PERSONA QUE DESPLIEGA EL CONTRATO
    ERC20Basic token;
    
    //constructor
    constructor () public
    {
        owner = msg.sender;
        token = new ERC20Basic(1000);
    }
}