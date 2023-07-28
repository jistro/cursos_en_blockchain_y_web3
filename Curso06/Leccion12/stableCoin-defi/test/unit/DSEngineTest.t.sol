// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { DecentralizedStableCoin } from "../../src/DecentralizedStableCoin.sol";
import { DSEngine } from "../../src/DSEngine.sol";
import { DeployDS } from "../../script/DeployDS.s.sol";
import { HelperConfig } from "../../script/HelperConfig.s.sol";
import { ERC20Mock } from "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract DSEngineTest is Test {
    DeployDS deployer;
    DecentralizedStableCoin dsc;
    DSEngine dse;
    HelperConfig config;
    address ethUsdPriceFeed;
    address weth;

    //--=Accounts==--//
    address public user1 = makeAddr("user1");

    //--==constants==--//
    uint256 public constant AMOUNT_COLLATERAL = 10e18;
    uint256 public constant STARTING_ERC20_BALANCE = 10 ether;

    function setUp() public {
        deployer = new DeployDS();
        (dsc, dse, config) = deployer.run();
        (
            ethUsdPriceFeed,
            /*wbtcUsdPriceFeed*/,
            weth,
            /*wbtc*/,
            /*deployerKey*/
        ) = config.activeNetworkConfig();

        ERC20Mock(weth).mint(user1, STARTING_ERC20_BALANCE);
    }
    ///---==Price Feed Tests==---//////////////////////////////////////////////////
    function testGetUsdValue() public {
        uint256 ethAmount = 15e18;
        // teoria: (15e18) (2000 per eth) = 30,000e18
        uint256 expectedUsdValue = 30000e18;
        uint256 actualUsdValue = dse.getUSDValue(weth, ethAmount);
        assertEq(actualUsdValue, expectedUsdValue);
    }

    ///---==Deposit collateral Tests==---//////////////////////////////////////////

    function testRevertsIfCollateralZero() public {
        vm.startPrank(user1);
            ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);
            vm.expectRevert(DSEngine.DSEngine__NeedsMoreThanZero.selector);
            dse.depositCollateral(weth, 0);
        vm.stopPrank();
    }
    
}
