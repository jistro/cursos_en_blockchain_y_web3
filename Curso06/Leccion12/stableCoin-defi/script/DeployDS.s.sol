// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from "forge-std/Script.sol";
import { DecentralizedStableCoin } from "../src/DecentralizedStableCoin.sol";
import { DSEngine } from "../src/DSEngine.sol";
import { HelperConfig } from "./HelperConfig.s.sol";

contract DeployDS is Script {
    address[] public tokenAddresses;
    address[] public priceFeedAddresses;
    function run() external returns(DecentralizedStableCoin, DSEngine, HelperConfig){
        HelperConfig config = new HelperConfig();

        (address wethUsdPriceFeed, 
        address wbtcUsdPriceFeed, 
        address weth, address wbtc, 
        uint256 deployerKey) = config.activeNetworkConfig();

        tokenAddresses = [weth, wbtc];
        priceFeedAddresses = [wethUsdPriceFeed, wbtcUsdPriceFeed];

        vm.startBroadcast(deployerKey);
            DecentralizedStableCoin ds = new DecentralizedStableCoin();
            DSEngine dsEngine = new DSEngine(tokenAddresses, priceFeedAddresses, address(ds));
            ds.transferOwnership(address(dsEngine));
        vm.stopBroadcast();
        return (ds, dsEngine, config);
    }

}