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

contract DSCEngine is ReentrancyGuard {
    //--==Errors==--/////////////////////////////////////////////
    error DSCEngine__Constructor__TokenAndPriceFeedLengthsMustBeEqual();
    error DSCEngine__InvalidAddress(address _address);
    error DSCEngine__InvalidAmount(uint256 _amount);
    error DSCEngine__TransferFailed();

    //--==State Variables==--////////////////////////////////////
    uint256 private constant ADDITIONAL_FEED_PRECISION = 1e10;
    uint256 private constant PRECISION = 1e18;

    mapping(address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;
    mapping(address user => uint256 amauntDSMinted) private s_DSMinted;

    address[] private s_collateralTokens;

    DecentralizedStableCoin private i_ds;

    //--==Events==--/////////////////////////////////////////////
    event CollateralDeposited(
        address indexed user, 
        address indexed token, 
        uint256 amount
    );

    //--==Modifiers==--//////////////////////////////////////////

    modifier moreThanZero(uint256 _amount) {
        if (_amount == 0) {
            revert DSCEngine__InvalidAmount(_amount);
        }
        _;
    }

    modifier isAlloweToken(address _tokenAddress) {
        if (s_priceFeeds[_tokenAddress] == address(0)) {
            revert DSCEngine__InvalidAddress(_tokenAddress);
        }
        _;
    }

    //////////////////////--==Functions==--//////////////////////
    //--==Constructor==--////////////////////////////////////////
    constructor(address[] memory tokensAddresses, address[] memory priceFeedsAddresses, address dsTokenAddress) {
        /**
         *  @dev only USD Price Feed
         *  for example: ETH/USD, BTC/USD, ...
         */
        if (tokensAddresses.length != priceFeedsAddresses.length) {
            revert DSCEngine__Constructor__TokenAndPriceFeedLengthsMustBeEqual();
        }
        for (uint256 i = 0; i < tokensAddresses.length; i++) {
            s_priceFeeds[tokensAddresses[i]] = priceFeedsAddresses[i];
            s_collateralTokens.push(tokensAddresses[i]);
        }
        i_ds = DecentralizedStableCoin(dsTokenAddress);
    }

    //--==External Functions==--/////////////////////////////////

    function depositCollateralAndMintDS() external {}
    /**
     *  @notice follows CEI pattern (Check-Effect-Interaction)
     *  @param tokenCollateralAddress The address of the collateral token
     *  @param amountCollateral The amount of collateral to deposit
     */
    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral)
        external
        moreThanZero(amountCollateral)
        isAlloweToken(tokenCollateralAddress)
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if (!success) {
            revert DSCEngine__TransferFailed();
        }
    }

    function redeemCollateral() external {}

    function redeemCollateralForDS() external {}

    /**
     *  @notice follows CEI pattern (Check-Effect-Interaction)
     *  @param amountToMint The amount of DS to mint
     *  @notice they must have more collateral than the amount of 
     *  DS they want to mint (minimun threshold)
     */
    function mintDS(uint256 amountToMint) external moreThanZero(amountToMint) nonReentrant{
        s_DSMinted[msg.sender] += amountToMint;
        _revertIfHealthFactorIsBroken(msg.sender);
    }

    function burnDS() external {}

    function liquidate() external {}

    function getHealthFactor() external view {}

    //--==Private and Internal view Functions==--////////////////

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
     */ 
    function _healthFactor(address user) private view returns (uint256) {
        (uint256 totalDSMinted, uint256 collateralValueInUsd) = _getAccountInfo(user);
    }

    /**
     * 
     *  @param user The address of the user to check
     *  @notice 
     *  1. check health factor (do they have enough collateral?)
     *      i. if not, revert
     */
    function _revertIfHealthFactorIsBroken(address user) internal view {
        
    }

    //--==Public and External View Functions==--/////////////////
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
}
