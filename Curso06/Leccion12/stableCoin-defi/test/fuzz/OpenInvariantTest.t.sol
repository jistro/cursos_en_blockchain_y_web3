// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { StdInvariant } from "forge-std/StdInvariant.sol";
import { DecentralizedStableCoin } from "../../src/DecentralizedStableCoin.sol";
import { DSEngine } from "../../src/DSEngine.sol";
import { DeployDS } from "../../script/DeployDS.s.sol";
import { HelperConfig } from "../../script/HelperConfig.s.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ERC20Mock } from "@openzeppelin/contracts/mocks/ERC20Mock.sol";
import { MockV3Aggregator } from "../mocks/MockV3Aggregator.sol";
import {MockFailedMintDS} from "../mocks/MockFailedMintDS.sol";
/*
Our invariants
1- the total supply of DS should be less than the total collateral
2- getter view functions should never revert
*/

contract OpenInvariantTest is StdInvariant, Test {
    DeployDS deployer;
    DSEngine dse;
    DecentralizedStableCoin dsc;
    HelperConfig config;

    address wethUsdPriceFeed;
    address weth;
    address wbtcUsdPriceFeed;
    address wbtc;

    function setUp() external {
        deployer = new DeployDS();
        (dsc, dse,config) = deployer.run();
        (
            wethUsdPriceFeed,
            wbtcUsdPriceFeed,
            weth,
            wbtc,
            /*deployerKey*/
        ) = config.activeNetworkConfig();
        targetContract(address(dse));
    }

    function invariant_protocolMustHaveMoreValueThanTheTotalSupply() public view {
        uint256 totalSupply = dsc.totalSupply();
        uint256 totalWETHDeposited = IERC20(weth).balanceOf(address(dse));
        uint256 totalWBTCDeposited = IERC20(wbtc).balanceOf(address(dse));

        uint256 wethValue = dse.getUSDValue(weth, totalWETHDeposited);
        uint256 wbtcValue = dse.getUSDValue(wbtc, totalWBTCDeposited);
        console.log("wethValue: ", wethValue);
        console.log("wbtcValue: ", wbtcValue);
        console.log("totalSupply: ", totalSupply);
        assert (wethValue + wbtcValue >= totalSupply);
    }
}