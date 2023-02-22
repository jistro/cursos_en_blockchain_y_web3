// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 < 0.7.0;
pragma experimental ABIEncoderV2;

contract comparaStrings 
{
    function comparar(string memory Uno, string memory Dos) public view returns(bool)
    {
        bytes32 hashUno = keccak256( abi.encodePacked( Uno ) );
        bytes32 hashDos = keccak256( abi.encodePacked( Dos ) );
        
        if (hashUno == hashDos)
        {
            return true;
        }
        else 
        {
            return false;
        }
    }
}