// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Donation {
    address payable public owner;
    mapping(address => uint256) public donations;

    constructor() {
        owner = payable(msg.sender);
    }

    // ฟังก์ชันรับบริจาค
    function donate() public payable {
        donations[msg.sender] += msg.value;  // เก็บจำนวนเงินที่ผู้ใช้บริจาค
    }

    // ฟังก์ชันถอนเงินที่เก็บใน contract
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(address(this).balance >= amount, "Insufficient balance in contract");
        owner.transfer(amount);  // โอนเงินให้เจ้าของ
    }

    // ฟังก์ชันตรวจสอบยอดเงินใน contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;  // ดูยอดเงินใน contract
    }
}
