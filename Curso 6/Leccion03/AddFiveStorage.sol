// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;


import {SimpleStorage} from "./SimpleStorage.sol";

//heredamos
contract AddFiveStorage is SimpleStorage{
    /* function sayHello() public pure returns (string memory){
        return 'hola cara de bola';
    } */

    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber+5;
    }
}