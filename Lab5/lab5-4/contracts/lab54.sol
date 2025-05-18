// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Donation {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function donate() public payable {
        owner.transfer(msg.value);
    }
}