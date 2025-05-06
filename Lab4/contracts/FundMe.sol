// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public AddressToAmountPaid;
    address public owner;
    address[] public ListOfPerson;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        uint256 ethPrice = getPrice() / (10**8); // USD per ETH
        uint256 minUSD = (210 * 10**18) / ethPrice; // Minimum ETH (in wei)
        uint256 maxUSD = (520 * 10**18) / ethPrice; // Maximum ETH (in wei)
        require(msg.value >= minUSD, "Payment must be at least 210 USD");
        require(msg.value <= maxUSD, "Payment must not exceed 520 USD");
        AddressToAmountPaid[msg.sender] += msg.value;
        ListOfPerson.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface PriceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return PriceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface PriceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = PriceFeed.latestRoundData();
        return uint256(answer);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice() / (10**8);
        uint256 ethInusd = ethPrice * ethAmount;
        return ethInusd;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function withDraw() public onlyOwner payable {
        address payable sender = payable(msg.sender);
        sender.transfer(address(this).balance);
        for(uint256 i = 0; i < ListOfPerson.length; i++) {
            address AddrPayer = ListOfPerson[i];
            AddressToAmountPaid[AddrPayer] = 0;
        }
        ListOfPerson = new address[](0);
    }
}
