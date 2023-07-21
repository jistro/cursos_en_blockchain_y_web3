// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping (address => uint256) private s_balances;

    function name() public pure returns (string memory) {
        return "Donita Coin";
    }

    function symbol() public pure returns (string memory) {
        return "DONA";
    }

    function totalSupply() public pure returns (uint256) {
        return 20398 ether; /// 20398
    }

    function decimals() public pure returns (uint256) {
        return 2; /// 2398^2 = 2039800
    }

    function balanceOf(
        address _owner
    ) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(
        address _to, uint256 _value
    ) public returns (bool success) {
        uint256 previusBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _value;
        s_balances[_to] += _value;
        require(previusBalance == balanceOf(msg.sender) + balanceOf(_to), "Error: Transfer failed");
        return true;
    }
}