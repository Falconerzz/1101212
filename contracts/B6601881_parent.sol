// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// สร้าง Contract สำหรับจัดการข้อมูลนักฟุตบอลในแต่ละทีม
contract FootballTeam {
    
    // Mapping ที่ใช้เก็บข้อมูลของนักฟุตบอล โดยใช้ footballerId เป็น key
    // footballerId เป็นรหัสที่บ่งบอกว่าเป็นนักฟุตบอลคนไหน
    mapping(string => Footballer) public footballers;
    
    // กำหนดรูปแบบข้อมูลของนักฟุตบอล
    struct Footballer {
        string firstName;
        string surname;
        string nationality;
        uint256 shirtNumber;
        string position;
    }
    
    // ฟังก์ชันสำหรับการเพิ่มข้อมูลนักฟุตบอล
    // รับข้อมูลต่างๆ ที่เกี่ยวกับนักฟุตบอลแล้วเก็บลงใน mapping footballers
    function addFootballer(
        string memory footballerId, 
        string memory firstName, 
        string memory surname, 
        string memory nationality, 
        uint256  shirtNumber, 
        string memory position
    ) public {
        // บันทึกข้อมูลของนักฟุตบอลใน mapping โดยใช้ footballerId เป็น key
        footballers[footballerId] = Footballer({
            firstName: firstName,
            surname: surname,
            nationality: nationality,
            shirtNumber: shirtNumber,
            position: position
        });
    }

    // ฟังก์ชันสำหรับดึงข้อมูลนักฟุตบอลจาก footballerId
    // รับ input เป็น footballerId และคืนค่าเป็นข้อมูลของนักฟุตบอล
    function getFootballerInfo(string memory footballerId) public view returns (Footballer memory) {
        // คืนค่าข้อมูลของนักฟุตบอลตาม footballerId ที่ระบุ
        return footballers[footballerId];
    }
}
