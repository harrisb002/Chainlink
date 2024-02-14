// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error FundMe__NotOwner(); // Convention to start with name of contract ect. for custom error message

// Accepts the funding sent by users
contract FundMe {
    // Type Declarations
    using PriceConverter for uint256; // Allows the use of the PriceConverter library methods on uint256

    // Notes:
    // constant must be assigned at compile-time
    // immutable can be assigned at runtime but then cannot change

    // State variables
    uint256 public constant MINIMUM_USD = 50 * 1 ether; // This is the min amount to pass to the contract to fund it (i.e. to be a supporter)
    address private immutable i_owner;
    address[] private s_funders; // Minimum of 50$ to be a funder defined above
    mapping(address => uint256) private s_addressToAmountFunded; // Stores the amount a certain person has funded

    // Address of the price feed, however this will be casted to the AggregatorV3Interface, so can be used in the Price Converter library
    AggregatorV3Interface private s_priceFeed;

    // Modifiers
    modifier onlyOwner() {
        // require(msg.sender == i_owner);
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    // Get the amount sent by user in USD and make sure greater than minimum to be a supporter, 50$
    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD,
            "You need to spend more ETH!"
        );
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender); // Update amount being funded
    }

    // Allows the owner of the contract to withdraw the funds
    function withdraw() public onlyOwner {
        address[] memory funders = s_funders;
        // mappings can't be in memory, sorry!
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            s_addressToAmountFunded[funder] = 0; // Clear the amount the supporters have funded
        }
        s_funders = new address[](0); // Clears the addresses of those who have contributed in the past once withdrawn (Not necessary)
        // payable(msg.sender).transfer(address(this).balance); However better to use .call method
        (bool success, ) = i_owner.call{value: address(this).balance}(""); // Send the balance of the contract to owner
        require(success);
    }

    function getAddressToAmountFunded( // Get the amount this address has sent to contract thus far
        address fundingAddress
    ) public view returns (uint256) {
        return s_addressToAmountFunded[fundingAddress];
    }

    function getVersion() public view returns (uint256) { // Get the version of the price feed being used
        return s_priceFeed.version();
    }

    function getFunder(uint256 index) public view returns (address) { // Get the address of a funder at passed index
        return s_funders[index];
    }

    function getOwner() public view returns (address) { // Get owner of contract
        return i_owner;
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) { // Get the address of the price feed being used
        return s_priceFeed;
    }
}
