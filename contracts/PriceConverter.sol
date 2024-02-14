// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Allows access the different methods of the pricefeed on the address (contract) that is passed in
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Handles all the price feed contract calls and doing all the conversions between Ethereum and USD
library PriceConverter {

    function getPrice( // Get prce of Ethereum in USD
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData(); // Returns 5 things and only care about answer
        // ETH/USD rate in 18 digit
        // 1 Ether = 10 ** 18
        return uint256(answer * 10000000000); // Accounts for the number of decimal points (8) because (Solidity doesnt handle decimal points)
    }

    // 1000000000
    // call it get fiatConversionRate, since it assumes something about decimals
    // It wouldn't work for every aggregator
    function getConversionRate( // Get converted rate of USD for Ethereum
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed); // Call above contract with the priceFeed contract
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1 ether;
        // the actual ETH/USD conversation rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}
