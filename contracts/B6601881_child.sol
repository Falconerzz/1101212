// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// นำเข้า Parent Contract (FootballTeam) เพื่อให้ Child Contract สามารถใช้ฟังก์ชันของ Parent Contract ได้
import "./B6601881_parent.sol";

// สร้าง Contract ที่สืบทอดจาก FootballTeam (Parent Contract)
contract FootballerDetails is FootballTeam {

    // ฟังก์ชันสำหรับดึงรายละเอียดของนักฟุตบอลจาก footballerId
    // ฟังก์ชันนี้จะใช้ฟังก์ชัน getFootballerInfo จาก Parent Contract
    function getDetailsById(string memory footballerId) public view returns (
        string memory firstName, 
        string memory surname,
        string memory nationality,
        uint256 shirtNumber, 
        string memory position
    ) {
        // เรียกใช้ฟังก์ชัน getFootballerInfo ของ Parent Contract เพื่อดึงข้อมูลของนักฟุตบอล
        Footballer memory f = getFootballerInfo(footballerId);
        
        // คืนค่ารายละเอียดของนักฟุตบอล
        return (f.firstName, f.surname, f.nationality, f.shirtNumber, f.position);
    }
}
