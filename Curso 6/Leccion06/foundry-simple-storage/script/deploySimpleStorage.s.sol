// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import "forge-std/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";
contract DeploySimpleStorage is Script{
    function run() external returns (SimpleStorage){
        // ejecutara y mostrara cuando usemos el comando forge script
        vm.startBroadcast();
        SimpleStorage simpleStorage = new SimpleStorage();
        vm.stopBroadcast();
        return simpleStorage;
    }
}