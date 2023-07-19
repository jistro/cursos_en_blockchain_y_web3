// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DEPLOY_FundMe} from "../../script/DEPLOYFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract IntegrationTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user"); // genera un address para el donador

    function setUp() external{
        DEPLOY_FundMe deployFundMe = new DEPLOY_FundMe();
        fundMe = deployFundMe.run();
        
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fund_FundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdraw_FundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
        
    }
}