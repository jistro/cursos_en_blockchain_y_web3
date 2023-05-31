// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error TransferFailed();

contract StakeContract {
    mapping (address => mapping (address => uint256)) public stakes_balances;

    function stake(address _token, uint256 _amount) external returns (bool) {
        stakes_balances[msg.sender][_token] += _amount;
        bool succsess = IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        if (!succsess) revert TransferFailed();
        return succsess;
    }
}