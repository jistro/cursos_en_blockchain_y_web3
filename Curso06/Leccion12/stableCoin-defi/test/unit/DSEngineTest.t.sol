// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
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
    address wethUsdPriceFeed;
    address weth;
    address wbtcUsdPriceFeed;
    address wbtc;

    //--=Accounts==--//
    address public user1 = makeAddr("user1");

    //--==constants==--//
    uint256 public constant AMOUNT_COLLATERAL = 10e18;
    uint256 public constant STARTING_ERC20_BALANCE = 10 ether;

    function setUp() public {
        deployer = new DeployDS();
        (dsc, dse, config) = deployer.run();
        (
            wethUsdPriceFeed,
            wbtcUsdPriceFeed,
            weth,
            wbtc,
            /*deployerKey*/
        ) = config.activeNetworkConfig();

        ERC20Mock(weth).mint(user1, STARTING_ERC20_BALANCE);
    }

    ///---==Constructor Tests==---//////////////////////////////////////////////////
    address[] public t_tokenAddresses;
    address[] public t_priceFeedAddresses;
    function testRevertsIsTokenLengthDosentMatchPriceFeeds() public {
        t_tokenAddresses.push(weth);
        t_priceFeedAddresses.push(wethUsdPriceFeed);
        t_priceFeedAddresses.push(wbtcUsdPriceFeed);
        vm.startPrank(user1);
            vm.expectRevert(DSEngine.DSEngine__Constructor__TokenAndPriceFeedLengthsMustBeEqual.selector);
            new DSEngine(t_tokenAddresses, t_priceFeedAddresses, address(dsc));
        vm.stopPrank();
    }
    
    ///---==Price Feed Tests==---//////////////////////////////////////////////////
    function testGetUsdValue() public {
        uint256 ethAmount = 15e18;
        // teoria: (15e18) (2000 per eth) = 30,000e18
        uint256 expectedUsdValue = 30000e18;
        uint256 actualUsdValue = dse.getUSDValue(weth, ethAmount);
        assertEq(actualUsdValue, expectedUsdValue);
    }

    function testGetTokenAmountFromUSD() public {
        uint256 usdAmount = 100e18;
        uint256 expectedWeth= 0.05 ether;
        uint256 actualWeth = dse.getTokenAmountFromUSD(weth, usdAmount);
        console.log("weth", actualWeth);
        assertEq(actualWeth, expectedWeth);
    }

    ///---==Deposit collateral Tests==---//////////////////////////////////////////

    function testRevertsIfCollateralZero() public {
        vm.startPrank(user1);
            ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);
            vm.expectRevert(DSEngine.DSEngine__NeedsMoreThanZero.selector);
            dse.depositCollateral(weth, 0);
        vm.stopPrank();
    }

    function testRevertsWithUnapprovedCollateral() public {
        ERC20Mock fakeToken = new ERC20Mock("Fake Token", "FKE", user1, AMOUNT_COLLATERAL);
        vm.startPrank(user1);
            vm.expectRevert(DSEngine.DSEngine__InvalidAddress.selector);
            dse.depositCollateral(address(fakeToken), AMOUNT_COLLATERAL);
        vm.stopPrank();
    }

    modifier depositWETHCollateral {
        vm.startPrank(user1);
            ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);
            dse.depositCollateral(weth, AMOUNT_COLLATERAL);
        vm.stopPrank();
        _;
    }
    
    function testCanDepositCollateralAndGetAccountInfo() public depositWETHCollateral {
        (uint256 totalDSMinted, uint256 totalCollateralValue) = dse.getAccountInfo(user1);   
        uint256 expectedDepositAmount= dse.getTokenAmountFromUSD(weth, totalCollateralValue);
        uint256 expectedTotalDSMinted = 0;
        assertEq(totalDSMinted, expectedTotalDSMinted);
        assertEq(expectedDepositAmount, AMOUNT_COLLATERAL);
        
    }
}
