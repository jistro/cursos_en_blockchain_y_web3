// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { DecentralizedStableCoin } from "./DecentralizedStableCoin.sol";
import { ReentrancyGuard } from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 *  @title Engine for Decentralized Stable Coin (DS)
 *  @author Kevin R. Padilla Islas (jistro.eth)
 *  El sistema esta hecho para que el token DS mantenga siempre una paridad de 1:1 con el dolar estadounidense
 *  El sistema tiene las siguentes propiedades:
 *  - El sistema esta colateralizado con wETH (Ethereum Wrapped) y wBTC (Bitcoin Wrapped)
 *  - Es sobrecolateralizado, es decir que en ningun momento el valor de la colateral puede ser menor
 *    al valor (en dolares) de los DS emitidos
 *  - Es de colateral Exógeno, es decir, el valor de la colateral es independiente del valor del DS
 *  - Es algorítmico
 *
 *  Es similar a DAI de MakerDAO pero en en lugar de tener gobernabilidad descentralizada, esta
 *  totalmente respaldado por wETH y wBTC
 *
 *  @notice El contrato es el motor del sistema, es decir, es el que se encarga de hacer las operaciones
 *  de deposito de colateral, emisión de DS, quema de DS y retiro de colateral
 *  @dev El contrato esta vagamanete basado en el contrato DssEngine de MakerDAO
 */

contract DSEngine is ReentrancyGuard {
    //--==Errors==--/////////////////////////////////////////////
    error DSEngine__Constructor__TokenAndPriceFeedLengthsMustBeEqual();
    error DSEngine__NeedsMoreThanZero();
    error DSEngine__InvalidAddress();
    error DSEngine__InvalidAmount(uint256 _amount);
    error DSEngine__TransferFailed();
    error DSEngine__BreakHealthFactor(uint256 _healthFactor);
    error DSEngine__MintFailed();
    error DSEngine__HealthFactorIsHealthy();
    error DSEngine__HealthFactorNotImproved();

    //--==State Variables==--////////////////////////////////////
    uint256 private constant ADDITIONAL_FEED_PRECISION = 1e10;
    uint256 private constant PRECISION = 1e18;
    uint256 private constant LIQUIDATION_THRESHOLD = 50;
    uint256 private constant LIQUIDATION_PRECISION = 100;
    uint256 private constant MIN_HEALTH_FACTOR = 1e18;
    uint256 private constant LIQUIDATOR_BONUS = 10; ///@notice means 10%

    mapping(address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;
    mapping(address user => uint256 amauntDSMinted) private s_DSMinted;

    address[] private s_collateralTokens;

    DecentralizedStableCoin private i_ds;

    //--==Events==--/////////////////////////////////////////////
    event CollateralDeposited(
        address indexed user, 
        address indexed token, 
        uint256 indexed amount
    );
    event CollateralRedeemed(
        address indexed redeemFrom,
        address indexed redeemTo,
        address indexed token, 
        uint256 amount
    );

    //--==Modifiers==--//////////////////////////////////////////

    modifier moreThanZero(uint256 _amount) {
        if (_amount == 0) {
            revert DSEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAlloweToken(address _tokenAddress) {
        if (s_priceFeeds[_tokenAddress] == address(0)) {
            revert DSEngine__InvalidAddress();
        }
        _;
    }

    //////////////////////--==Functions==--//////////////////////
    //--==Constructor==--////////////////////////////////////////
    constructor(
    address[] memory tokensAddresses, 
    address[] memory priceFeedsAddresses, 
    address dsTokenAddress
    ) {
        /**
         *  @dev only USD Price Feed
         *  for example: ETH/USD, BTC/USD, ...
         */
        if (tokensAddresses.length != priceFeedsAddresses.length) {
            revert DSEngine__Constructor__TokenAndPriceFeedLengthsMustBeEqual();
        }
        for (uint256 i = 0; i < tokensAddresses.length; i++) {
            s_priceFeeds[tokensAddresses[i]] = priceFeedsAddresses[i];
            s_collateralTokens.push(tokensAddresses[i]);
        }
        i_ds = DecentralizedStableCoin(dsTokenAddress);
    }

    //--==External Functions==--/////////////////////////////////

    /**
     * 
     *  @param tokenCollateralAddress The address of the collateral token
     *  @param amountCollateral The amount of collateral to deposit
     *  @param amountDSToMint The amount of DS to mint
     *  @notice this function will deposit collateral and mint DS in one transaction
     */
    function depositCollateralAndMintDS(
    address tokenCollateralAddress,
    uint256 amountCollateral,
    uint256 amountDSToMint
    ) external {
        depositCollateral(tokenCollateralAddress, amountCollateral);
        mintDS(amountDSToMint);
    }

    /**
     *  @notice follows CEI pattern (Check-Effect-Interaction)
     *  @param tokenCollateralAddress The address of the collateral token
     *  @param amountCollateral The amount of collateral to deposit
     */
    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral)
        public
        moreThanZero(amountCollateral)
        isAlloweToken(tokenCollateralAddress)
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if (!success) {
            revert DSEngine__TransferFailed();
        }
    }

    function redeemCollateral(address tokenCollateralAddress, uint256 amountCollateral) 
    public moreThanZero(amountCollateral) nonReentrant {
        _redeemCollateral(msg.sender, msg.sender, tokenCollateralAddress, amountCollateral);
        _revertIfHealthFactorIsBroken(msg.sender);
    }

    /**
     * 
     *  @param tokenCollateralAddress The address of the collateral token
     *  @param amountCollateral The amount of collateral to redeem
     *  @param amountDSToBurn  The amount of DS to burn
     *  @notice this function will burn DS and redeem collateral in one transaction
     */
    function redeemCollateralForDS(
    address tokenCollateralAddress, 
    uint256 amountCollateral, 
    uint256 amountDSToBurn
    ) external {
        burnDS(amountDSToBurn);
        /// @dev redeemCollateral revert if the health factor is broken
        redeemCollateral(tokenCollateralAddress, amountCollateral);
    }

    /**
     *  @notice follows CEI pattern (Check-Effect-Interaction)
     *  @param amountToMint The amount of DS to mint
     *  @notice they must have more collateral than the amount of 
     *  DS they want to mint (minimun threshold)
     */
    function mintDS(uint256 amountToMint) public moreThanZero(amountToMint) nonReentrant{
        s_DSMinted[msg.sender] += amountToMint;
        _revertIfHealthFactorIsBroken(msg.sender);
        bool minted = i_ds.mint(msg.sender, amountToMint);
        if (!minted) {
            revert DSEngine__MintFailed();
        }
    }

    function burnDS(uint256 amount) public moreThanZero(amount) nonReentrant{
        _burnDS(amount, msg.sender, msg.sender);
        _revertIfHealthFactorIsBroken(msg.sender); // if for preventing HF break but IDK if it's necessary
    }
    
    /**
     * 
     *  @param collateralAddress The address of the collateral token to liquidate from the user
     *  @param userAddress The address of the user to liquidate who broke the health factor
     *  the _healthFactor should be less than MIN_HEALTH_FACTOR
     *  @param debtToCover Amount of DS to burn to improve the health factor of the user
     *  @notice you can partially liquidate a user
     *  @notice you will get a liquidation bonus for taking the users collateral
     *  @notice This function working assumes the protocol is overcollateralized (200%) in order to
     *  this function to work
     *  @notice a know bug would be if the protocol is not overcollateralized, then 
     *  we wouldn't be able to incentivize liquidators to liquidate users
     *  Example:
     *  If the price of the collateral plummeted before anyone could be liquidated
     */
    function liquidate(
    address collateralAddress, 
    address userAddress, 
    uint256 debtToCover
    ) external moreThanZero(debtToCover) nonReentrant{
        uint256 startingHealthFactor = _healthFactor(userAddress);
        if (startingHealthFactor >= MIN_HEALTH_FACTOR) {
            revert DSEngine__HealthFactorIsHealthy();
        }
        uint256 tokenAmountFromDebtCovered = getTokenAmountFromUSD(
            collateralAddress, debtToCover);
        /** 
         *  @notice we giving a 10% bonus of <collateralAddress> to the liquidator
         *  @todo 
         *  - Implement a feature to liquidate in the event the protocol is 
         *    insolvent (less than 200% collateralized)
         */ 
        uint256 bonusCollateral = (tokenAmountFromDebtCovered * LIQUIDATOR_BONUS) / 
        LIQUIDATION_PRECISION;
        
        uint256 totalCollateralToLiquidate = tokenAmountFromDebtCovered + bonusCollateral;
        _redeemCollateral(
            userAddress, 
            msg.sender, 
            collateralAddress, 
            totalCollateralToLiquidate
        );
        _burnDS(debtToCover, userAddress, msg.sender);

        uint256 endingHealthFactor = _healthFactor(userAddress);
        if (endingHealthFactor <= startingHealthFactor) {
            revert DSEngine__HealthFactorNotImproved();
        }
        _revertIfHealthFactorIsBroken(msg.sender);
    }

    function getHealthFactor() external view {}

    //--==Private and Internal view Functions==--////////////////

    /**
     *  @dev Low-level internal function to burn DS and redeem collateral 
     *  DO NOT CALL THIS FUNCTION DIRECTLY UNLESS THE FUNCTION YOU ARE CALLING
     *  IS ALREADY REVERTING IF THE HEALTH FACTOR IS BROKEN
     */
    function _burnDS(uint256 amountDSToBurn, address onBehalfOf, address dsFrom) private {
        s_DSMinted[onBehalfOf] -= amountDSToBurn;
        bool success = i_ds.transferFrom(dsFrom, address(this), amountDSToBurn);
        if (!success) {
            revert DSEngine__TransferFailed();
        }
        i_ds.burn(amountDSToBurn);
    }

    function _redeemCollateral(
    address from, 
    address to,
    address tokenCollateralAddress, 
    uint256 amountCollateral
    ) private {
        s_collateralDeposited[from][tokenCollateralAddress] -= amountCollateral;
        emit CollateralRedeemed(from, to, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transfer(to, amountCollateral);
        if (!success) {
            revert DSEngine__TransferFailed();
        }
    }

    function _getAccountInfo(address user) private view 
    returns (
        uint256 totalDSMinted, 
        uint256 collateralValueInUsd
    ) {
        totalDSMinted = s_DSMinted[user];
        collateralValueInUsd = getAccountCollateralValue(user);
    }

    /**
     *  @param user The address of the user to check
     *  @notice returns how close to the liquidation threshold the user is
     *  if a user goes below the liquidation threshold, they can be liquidated
     *  MUST BE 200% COLLATERALIZED
     */ 
    function _healthFactor(address user) private view returns (uint256) {
        (uint256 totalDSMinted, uint256 collateralValueInUsd) = _getAccountInfo(user);
        uint256 collateralAdjustedForThreshold = (collateralValueInUsd * LIQUIDATION_THRESHOLD) / LIQUIDATION_PRECISION;
        return (collateralAdjustedForThreshold * PRECISION) / totalDSMinted;
    }

    /**
     * 
     *  @param user The address of the user to check
     *  @notice 
     *  1. check health factor (do they have enough collateral?)
     *      i. if not, revert
     */
    function _revertIfHealthFactorIsBroken(address user) internal view {
        uint256 healthFactor = _healthFactor(user);
        if (healthFactor < MIN_HEALTH_FACTOR) {
            revert DSEngine__BreakHealthFactor(healthFactor);
        }
    }

    //--==Public and External View Functions==--/////////////////
    function getTokenAmountFromUSD(
    address tokenAddress,
    uint256 usdAmountInWei
    ) public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(s_priceFeeds[tokenAddress]);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return (usdAmountInWei * PRECISION) / (uint256(price) * ADDITIONAL_FEED_PRECISION);
    }

    /**
     *  @param user The address of the user to check
     *  @notice returns the value of the collateral in USD
     *  @dev loop through all the collateral tokens and get the price feed
     *  for each one, then multiply the amount of collateral by the price feed
     *  and add it to the total
     */ 
    function getAccountCollateralValue(address user) public view returns (uint256 totalCollateralValue) {
        for(uint256 i = 0; i < s_collateralTokens.length; i++) {
            address tokenAddress = s_collateralTokens[i];
            uint256 amountCollateral = s_collateralDeposited[user][tokenAddress];
            totalCollateralValue += getUSDValue(tokenAddress, amountCollateral);
        }
        return totalCollateralValue;
    }

    function getUSDValue(address token, uint256 amount) public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(s_priceFeeds[token]);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return ((uint256(price) * ADDITIONAL_FEED_PRECISION) * amount) / PRECISION;
    }

    function getAccountInfo(address user) 
    external view returns (uint256 totalDSMinted, uint256 collateralValueInUsd) {
        (totalDSMinted,collateralValueInUsd)  = _getAccountInfo(user);
    }
        
}
