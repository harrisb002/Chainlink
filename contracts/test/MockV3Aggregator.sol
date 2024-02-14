// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/tests/MockV3Aggregator.sol";

// When the the smart contracts are ran and deployed, need to do on a real or test network
// that has a chainlink smart contract deployed that contains the price information
// When doing this locally, this needs to be 'mocked' using this contract