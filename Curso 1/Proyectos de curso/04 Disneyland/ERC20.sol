// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Disney is ERC20 {
    address public _owner;

    constructor(uint256 initialSupply) ERC20("DisneyDollars", "DYD")  {
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
        _owner = msg.sender; //establecemos el propietario del contrato
    }
    
    function decimals() public view virtual override returns (uint8) {
        return 2; //definimos que seran 2 decimales
    }

    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }

    //transfiere al propietario del contrato
    function transferToOwner(uint amount) public {
        _transfer(msg.sender, _owner, amount);
    }
}

