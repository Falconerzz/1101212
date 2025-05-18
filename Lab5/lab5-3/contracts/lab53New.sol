// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenTransfer {
    mapping(address => uint256) public balances;
    uint public totalSupply;
    address public owner;

    // Constructor to mint initial tokens to the owner
    constructor(uint _initialSupply) {
        owner = msg.sender;
        balances[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    function transfer(address recipient, uint256 amount) public {
        require(msg.sender == owner, "Only the owner can transfer tokens");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        totalSupply -= amount;
    }
}
