// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoyaltyProgram {
    mapping (address => uint256) public points;

    function awardPoints(address user, uint amount) public {
        points[user] += amount;
    }
}