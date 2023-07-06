// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DEPLOY_FundMe} from "../../script/DEPLOYFundMe.s.sol";
import {FundFundMe} from "../../script/interactions.s.sol";

contract IntegrationTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user"); // genera un address para el donador

    function setUp() external{
        DEPLOY_FundMe deployFundMe = new DEPLOY_FundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, 100 ether);
    }

    function testUserCanFund() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        address funder = fundMe.getFunder(0);
        assert(funder == USER);
        
    }
}