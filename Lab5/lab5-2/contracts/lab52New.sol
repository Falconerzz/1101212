// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract LoyaltyProgram {
    address public owner;
    mapping (address => uint8) public points;

    // กำหนดเจ้าของ contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier สำหรับตรวจสอบว่าเป็นเจ้าของหรือไม่
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can reward points");
        _;
    }

    // ฟังก์ชันเพิ่มคะแนน (ให้เจ้าของหรือผู้ที่ได้รับอนุญาตทำได้)
    function reward(address user, uint8 pointsToAdd) public onlyOwner {
        uint8 newPoints = points[user] + pointsToAdd;

        // ตรวจสอบว่าคะแนนใหม่จะเกิน 255 หรือไม่
        if (newPoints < points[user]) {
            points[user] = 255;  // หากเกินขีดจำกัดให้ตั้งค่าเป็น 255
        } else {
            points[user] = newPoints;  // หากไม่เกินขีดจำกัด ให้เพิ่มคะแนนตามปกติ
        }
    }
}
