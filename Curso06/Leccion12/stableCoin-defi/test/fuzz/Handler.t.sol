// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { DecentralizedStableCoin } from "../../src/DecentralizedStableCoin.sol";
import { DSEngine } from "../../src/DSEngine.sol";
import { ERC20Mock } from "@openzeppelin/contracts/mocks/ERC20Mock.sol";
import { MockV3Aggregator } from "../mocks/MockV3Aggregator.sol";

contract Handler is Test{
    DecentralizedStableCoin dsc;
    DSEngine dse;

    ERC20Mock weth;
    ERC20Mock wbtc;

    uint256 public timesMintIsCalled;

    address[] public usersWhithCollateralDeposited;

    uint256 MAX_DEPOSIT_SIZE = type(uint96).max;

    MockV3Aggregator public wethUsdPriceFeed;
    MockV3Aggregator public wbtcUsdPriceFeed;

    constructor(DSEngine _dse, DecentralizedStableCoin _dsc) {
        dsc = _dsc;
        dse = _dse;
        address[] memory collateralContracts = dse.getCollateralTokens();
        weth = ERC20Mock(collateralContracts[0]);
        wbtc = ERC20Mock(collateralContracts[1]);
        wethUsdPriceFeed = MockV3Aggregator(dse.getCollateralTokenPriceFeed(address(weth)));
        wbtcUsdPriceFeed = MockV3Aggregator(dse.getCollateralTokenPriceFeed(address(wbtc)));
    }
    
    //deposit collateral
    function depositCollateral(uint256 collateralSeed, uint256 amount) public {
        ERC20Mock collateralToken = _getCollateralTokenFromSeed(collateralSeed);
        amount = bound(amount, 1, MAX_DEPOSIT_SIZE); //bound the amount to the max deposit size from 1 to MAX_DEPOSIT_SIZE
        
        vm.startPrank(msg.sender);
            collateralToken.mint(msg.sender, amount);
            collateralToken.approve(address(dse), amount);
            dse.depositCollateral(address(collateralToken), amount);
        vm.stopPrank();
        usersWhithCollateralDeposited.push(msg.sender);
    }

    //redeem collateral
    function redeemCollateral(uint256 collateralSeed, uint256 amount) public {
        ERC20Mock collateralToken = _getCollateralTokenFromSeed(collateralSeed);
        uint256 maxCollateralToRedeem = dse.getCollateralBalanceOfUser(address(collateralToken), msg.sender);
        amount = bound(amount, 0, maxCollateralToRedeem); //bound the amount to the max collateral to redeem from 1 to maxCollateralToRedeem
        if (amount == 0) {return;}
        vm.startPrank(msg.sender);
            dse.redeemCollateral(address(collateralToken), amount);
        vm.stopPrank();
    }
    /*
    function updateWETHCollateralPrice(uint96 price) public {
        int256 newPriceInt = int256(uint256(price));
        wethUsdPriceFeed.updateAnswer(newPriceInt);
    }
    */
    

    function mintDs(uint256 amount, uint256 addressSeed) public {
        if (usersWhithCollateralDeposited.length == 0) {return;}
        address sender = usersWhithCollateralDeposited[addressSeed%usersWhithCollateralDeposited.length];
        (uint256 totalDSMinted, uint256 collateralValueInUsd) =  dse.getAccountInfo(sender);
        int256 maxDsToMint = (int256(collateralValueInUsd)/2) - int256(totalDSMinted);
        if (maxDsToMint < 0) {return;}
        amount = bound(amount, 0, uint256(maxDsToMint));
        if (amount == 0) {return;}
        vm.startPrank(sender);
            dse.mintDS(amount);
        vm.stopPrank();
        timesMintIsCalled++;
    }


    ///----------------- Helper functions -----------------///
    function _getCollateralTokenFromSeed(uint256 collateralSeed) private view returns (ERC20Mock) {
        if ((collateralSeed%2) == 0) {
            return weth;
        }
        return wbtc;
    }


}