// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoyaltyProgram {
    address public owner;
    mapping (address => uint256) public points;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can award points");
        _;
    }

    function awardPoints(address user, uint amount) public onlyOwner {
        points[user] += amount;
    }
}
