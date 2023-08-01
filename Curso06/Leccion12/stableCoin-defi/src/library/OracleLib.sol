// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title OracleLib
 * @author Kevin R. Padilla Islas (jistro.eth)
 * @notice this library is used to check the chainlink oracle for stale data
 * if a price is stale, it will revert, and render the contract unusable- this is a feature
 * we want the engine to freeze if the price is stale
 * 
 * if the chainlink network is close and the protocol has a lot of money well... 
 */

library OracleLib {
    error OracleLibStalePrice();
    uint256 private constant TIMEOUT = 3 hours;
    function staleCheckLatestRoundData(AggregatorV3Interface priceFeed) 
    public view returns (uint80, int256, uint256, uint256, uint80)  {
        (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        uint256 timeElapsed = block.timestamp - updatedAt;
        if (timeElapsed > TIMEOUT) {
            revert OracleLibStalePrice();
        }
        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }
}