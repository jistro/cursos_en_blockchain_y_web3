// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        uint256 ticketPrice; 
        uint256 interval;
        address vrfCordinator; 
        bytes32 KeyHash;
        uint64 subscriptionId;
        uint32 callbackGasLimit;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 43113){
            activeNetworkConfig = getFujiAvaxConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            ticketPrice: 0.001 ether,
            interval: 30,
            vrfCordinator: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625,
            KeyHash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            subscriptionId: 0, //Update this
            callbackGasLimit: 500000
        });
    }

    function getFujiAvaxConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            ticketPrice: 0.01 ether,
            interval: 30,
            vrfCordinator: 	0x2eD832Ba664535e5886b75D64C46EB9a228C2610,
            KeyHash: 0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61,
            subscriptionId: 0, //Update this
            callbackGasLimit: 1500000
        });
    }

    function getOrCreateAnvilConfig()  public view returns (NetworkConfig memory) {
        if (activeNetworkConfig.vrfCordinator != address(0)){
            return activeNetworkConfig;
        }
        uint96 baseFee = 0.25 ether;
        uint96 gasPriceLink = 1e9; // 1 gwei
        vm.startBroadcast();
            VRFCoordinatorV2Mock vrfCordinator = new VRFCoordinatorV2Mock(
                baseFee,
                gasPriceLink
            );
        vm.stopBroadcast();

        return NetworkConfig({
            ticketPrice: 0.01 ether,
            interval: 30,
            vrfCordinator: address(vrfCordinator),
            KeyHash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            subscriptionId: 0, //Update this
            callbackGasLimit: 1500000
        });
    }
}