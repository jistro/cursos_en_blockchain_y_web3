// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DEPLOY_FundMe is Script {
    function run() external returns(FundMe) {

        HelperConfig helperConfig = new HelperConfig();

        address APriceFeedAddress = helperConfig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe newContract = new FundMe(APriceFeedAddress);
        vm.stopBroadcast();
        return newContract;
    }
}