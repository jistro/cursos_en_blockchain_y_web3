// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Fichas is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("FichasLoteria", "FICHA")  {
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
    }
    function decimals() public view virtual override returns (uint8) {
        return 2; //definimos que seran 2 decimales
    }

    function mint(uint amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    // funcion para trajnsferir del ususario al owner
    // solo el owner puede hacer la funcion
    // se aprueba la cantidad de tokens que se van a transferir
    // se transfieren los tokens
    // se revierte la aprobacion
    // se revierte la transferencia
    function transferFromUser(address _user, uint256 _amount) public onlyOwner {
        approve(_user, _amount);
        _transfer(_user, msg.sender, _amount);
    }
}