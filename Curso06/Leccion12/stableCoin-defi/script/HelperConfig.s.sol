// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from "forge-std/Script.sol";
import { DecentralizedStableCoin } from "../src/DecentralizedStableCoin.sol";
import { DSEngine } from "../src/DSEngine.sol";
import { MockV3Aggregator } from "../test/mocks/MockV3Aggregator.sol";
import { ERC20Mock } from "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        address wethUsdPriceFeed;
        address wbtcUsdPriceFeed;
        address weth;
        address wbtc;
        uint256 deployerKey;
    }

    uint8 public constant DECIMALS = 8;
    int256 public constant ETH_USD_PRICE = 2000e8;
    int256 public constant BTC_USD_PRICE = 10000e8;
    uint256 public constant DEFAULT_PRIVATE_KEY_ANVIL = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    NetworkConfig public activeNetworkConfig;

    constructor(){
        if (block.chainid == 11155111){
            activeNetworkConfig = getSepoliaETHConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }


    function getSepoliaETHConfig() public view returns(NetworkConfig memory) {
        return NetworkConfig ({
            wethUsdPriceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
            wbtcUsdPriceFeed: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43,
            weth: 0xdd13E55209Fd76AfE204dBda4007C227904f0a81,
            wbtc: 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063,
            deployerKey: vm.envUint("PRIVATE_KEY")
        });
    }
    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory anvilNetworkConfig) {
        // Check to see if we set an active network config
        if (activeNetworkConfig.wethUsdPriceFeed != address(0)) {
            return activeNetworkConfig;
        }

        vm.startBroadcast();
            MockV3Aggregator ethUsdPriceFeed = new MockV3Aggregator(
                DECIMALS,
                ETH_USD_PRICE
            );
            ERC20Mock weth = new ERC20Mock("Wrapped Ether", "WETH", msg.sender, 1000e8);
            MockV3Aggregator btcUsdPriceFeed = new MockV3Aggregator(
                DECIMALS,
                BTC_USD_PRICE
            );
            ERC20Mock wbtc = new ERC20Mock("Wrapped Bitcoin", "WBTC", msg.sender, 1000e8);
        vm.stopBroadcast();
        return NetworkConfig({
            wethUsdPriceFeed: address(ethUsdPriceFeed),
            wbtcUsdPriceFeed: address(btcUsdPriceFeed),
            weth: address(weth),
            wbtc: address(wbtc),
            deployerKey: DEFAULT_PRIVATE_KEY_ANVIL
        });
    }
}