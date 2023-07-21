// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { OZToken } from "../src/OZToken.sol";

contract DeployToken is Script {
    function run() external returns (OZToken){
        uint256 initialSupply = 20398 ether;
        vm.startBroadcast();
            OZToken token = new OZToken(initialSupply);
        vm.stopBroadcast();
        return token;
    }
}