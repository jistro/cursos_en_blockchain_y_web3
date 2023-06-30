// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DEPLOY_FundMe} from "../script/DEPLOYFundMe.s.sol";

contract FundMeTest is Test{

    FundMe fundMe;

    function setUp() external {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DEPLOY_FundMe deployFundMe = new DEPLOY_FundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimunDolarIsFive() public {
        
        //console.log(cost);
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(fundMe.i_owner());
        console.log(address(this));
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}