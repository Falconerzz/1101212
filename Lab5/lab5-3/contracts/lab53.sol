// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenTransfer {
    mapping (address => uint256) public balances;
    uint public totalSupply;

    function transfer(address recipient, uint256 amount) public {
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }
}