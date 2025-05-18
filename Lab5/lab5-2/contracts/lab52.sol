// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract LoyaltyProgram {
    mapping (address => uint8) public points;

    function reward(address user, uint8 pointsToAdd) public {
        points[user] = points[user] + pointsToAdd;
    }
}
