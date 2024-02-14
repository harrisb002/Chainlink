// SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity ^0.8.20;
// 2. Imports
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error FundMe__NotOwner(); // Convention to start with name of contract ect.

// Accepts the funding sent by users
contract FundMe{
    // Type Declarations
    using PriceConverter for uint256; // Allows the use of the PriceConverter library methods on uint256
    
    // Notes: 
    // constant must be assigned at compile-time 
    // immutable can be assigned at runtime but then cannot change
    
    // State variables
    uint256 public constant MINIMUM_USD = 50 * 1 ether; // This is the min amount to pass to the contract to fund it (i.e. to be a supporter)
    address private immutable i_owner;
    address[] private s_funders;    // Minimum of 50$ to be a funder defined above
    mapping(address => uint256) private s_addressToAmountFunded; // Stores the amount a certain person has funded

    // Address of the price feed, however this will be casted to the AggregatorV3Interface, so can be used in the Price Converter library
    AggregatorV3Interface private s_priceFeed; 

    // Modifiers
    modifier onlyOwner() {
        // require(msg.sender == i_owner);
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

}