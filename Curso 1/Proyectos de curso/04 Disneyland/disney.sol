// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";

contract Disney {
    // instancia del contrato token
    ERC20Disney private token;

    // direccion de disney (owner)
    address payable public owner;

    // constructor
    constructor() {
        token = new ERC20Disney(1000);
        owner = payable(msg.sender);
    }
}