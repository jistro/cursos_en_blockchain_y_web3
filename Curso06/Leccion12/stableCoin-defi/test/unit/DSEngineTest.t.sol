// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { DecentralizedStableCoin } from "../../src/DecentralizedStableCoin.sol";
import { DSEngine } from "../../src/DSEngine.sol";
import { DeployDS } from "../../script/DeployDS.s.sol";
import { HelperConfig } from "../../script/HelperConfig.s.sol";
import { ERC20Mock } from "@openzeppelin/contracts/mocks/ERC20Mock.sol";
import { MockV3Aggregator } from "../mocks/MockV3Aggregator.sol";
import {MockFailedMintDS} from "../mocks/MockFailedMintDS.sol";

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
    uint256 public constant MIN_HEALTH_FACTOR = 1e18;
    uint256 public constant LIQUIDATION_THRESHOLD = 50;

    uint256 amountToMint = 100 ether;
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

    function testCanDepositCollateralWithoutMinting() public depositWETHCollateral {
        uint256 userBalance = dsc.balanceOf(user1);
        assertEq(userBalance, 0);
    }

    function testCanDepositedCollateralAndGetAccountInfo() public depositWETHCollateral {
        (uint256 totalDscMinted, uint256 collateralValueInUsd) = dse.getAccountInfo(user1);
        uint256 expectedDepositedAmount = dse.getUSDValue(weth, collateralValueInUsd);
        assertEq(totalDscMinted, 0);
    }
    //---==Deposit and Mint Tests==---/////////////////////////////////////////////
    function testRevertsIfMintedDscBreaksHealthFactor() public {
        (, int256 price,,,) = MockV3Aggregator(wethUsdPriceFeed).latestRoundData();
         amountToMint = (AMOUNT_COLLATERAL * (uint256(price) * dse.getAdditionalFeedPrecision())) / dse.getPrecision();
        vm.startPrank(user1);
        ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);

        uint256 expectedHealthFactor =
            dse.calculateHealthFactor(amountToMint, dse.getUSDValue(weth, AMOUNT_COLLATERAL));
        vm.expectRevert(abi.encodeWithSelector(DSEngine.DSEngine__BreakHealthFactor.selector));
        dse.depositCollateralAndMintDS(weth, AMOUNT_COLLATERAL, amountToMint);
        vm.stopPrank();
    }

    modifier depositedCollateralAndMintedDsc() {
        vm.startPrank(user1);
        ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);
        dse.depositCollateralAndMintDS(weth, AMOUNT_COLLATERAL, amountToMint);
        vm.stopPrank();
        _;
    }

    function testCanMintWithDepositedCollateral() public depositedCollateralAndMintedDsc {
        uint256 userBalance = dsc.balanceOf(user1);
        assertEq(userBalance, amountToMint);
    }

    ///---==Mint DS Tests==---/////////////////////////////////////////////////////
    function testRevertsIfMintFails() public {
        // Arrange - Setup
        MockFailedMintDS mockDs = new MockFailedMintDS();
        t_tokenAddresses = [weth];
        t_priceFeedAddresses = [wethUsdPriceFeed];
        address owner = msg.sender;
        vm.prank(owner);
        DSEngine mockDse = new DSEngine(
            t_tokenAddresses,
            t_priceFeedAddresses,
            address(mockDs)
        );
        mockDs.transferOwnership(address(mockDse));
        // Arrange - User
        vm.startPrank(user1);
        ERC20Mock(weth).approve(address(mockDse), AMOUNT_COLLATERAL);

        vm.expectRevert(DSEngine.DSEngine__MintFailed.selector);
        mockDse.depositCollateralAndMintDS(weth, AMOUNT_COLLATERAL, amountToMint);
        vm.stopPrank();
    }

    function testRevertsIfMintAmountIsZero() public {
        vm.startPrank(user1);
        ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);
        dse.depositCollateralAndMintDS(weth, AMOUNT_COLLATERAL, amountToMint);
        vm.expectRevert(DSEngine.DSEngine__NeedsMoreThanZero.selector);
        dse.mintDS(0);
        vm.stopPrank();
    }

    function testRevertsIfMintAmountBreaksHealthFactor() public {
        // 0xe580cc6100000000000000000000000000000000000000000000000006f05b59d3b20000
        // 0xe580cc6100000000000000000000000000000000000000000000003635c9adc5dea00000
        (, int256 price,,,) = MockV3Aggregator(wethUsdPriceFeed).latestRoundData();
        amountToMint = (AMOUNT_COLLATERAL * (uint256(price) * dse.getAdditionalFeedPrecision())) / dse.getPrecision();

        vm.startPrank(user1);
        ERC20Mock(weth).approve(address(dse), AMOUNT_COLLATERAL);
        dse.depositCollateral(weth, AMOUNT_COLLATERAL);

        uint256 expectedHealthFactor =
            dse.calculateHealthFactor(amountToMint, dse.getUSDValue(weth, AMOUNT_COLLATERAL));
        vm.expectRevert(abi.encodeWithSelector(DSEngine.DSEngine__BreakHealthFactor.selector));
        dse.mintDS(amountToMint);
        vm.stopPrank();
    }

    function testCanMintDsc() public depositWETHCollateral {
        vm.prank(user1);
        dse.mintDS(amountToMint);

        uint256 userBalance = dsc.balanceOf(user1);
        assertEq(userBalance, amountToMint);
    }


}
