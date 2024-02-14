// SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity ^0.8.20;
// 2. Imports
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

// Accepts the funding sent by users
contract FundMe{}