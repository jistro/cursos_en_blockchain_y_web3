// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 *  @title Decentraliozed stable-coin
 *  @author Kevin R. Padilla Islas (jistro.eth)
 *  1. Relatively stable: Anchored to a fiat currency.
 *      1. We will use the Chainlink price feed https://docs.chain.link/data-feeds/price-feeds
 *      2. We will implement a function to swap ETH/BTC tokens for stable tokens.
 *  2. Stability mechanism (minting): Algorithmic (decentralized).
 *      1. Individuals can mint the stablecoin with sufficient collateral.
 *  3. Collateral: Exogenous based on cryptocurrencies.
 *      1. We will use wETH and wBTC as collateral.
 *  This meant to be gobern by DSCEngine is just the ERC20 implementation of ur stablecoin.
 */

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoin__MustBeMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedsBalance(uint256 _amount, uint256 balance);
    error DecentralizedStableCoin__NotMintToZeroAddress();
    error DecentralizedStableCoin__MintMustBeMoreThanZero();

    constructor() ERC20("DecentralizedStableCoin", "DS") {}

    function burn(uint256 _amount) public virtual override onlyOwner {
        uint256 balance = balanceOf(_msgSender());
        if (_amount <= 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }
        if (balance < _amount) {
            revert DecentralizedStableCoin__BurnAmountExceedsBalance(_amount, balance);
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert DecentralizedStableCoin__NotMintToZeroAddress();
        }
        if (_amount <= 0) {
            revert DecentralizedStableCoin__MintMustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}
