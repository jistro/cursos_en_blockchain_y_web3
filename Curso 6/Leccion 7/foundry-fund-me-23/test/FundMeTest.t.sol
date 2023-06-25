// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test{

    FundMe fundMe;

    function setUp() external {
        fundMe = new FundMe();
    }

    function testMinimunDolarIsFive() public {
        
        //console.log(cost);
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    //https://youtu.be/sas02qSFZ74?t=1250
    //me quede en 2:50
}