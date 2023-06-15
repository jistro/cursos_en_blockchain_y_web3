// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract simpleStorage {
    // this will get initialized to 0!
    // by default, the value of an uninitialized uint is 0 and is internal 
    uint256 favoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    // me quede en el minuto 2:40 https://www.youtube.com/watch?v=umepbfKp5rI
}