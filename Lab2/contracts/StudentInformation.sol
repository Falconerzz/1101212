// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentInformation {

    // Struct เพื่อเก็บข้อมูลนักเรียน
    struct Student {
        string studentID;
        string firstName;
        string surname;
        string houseNumber;
        string streetName;
        string city;
        string postcode;
    }

    // Mapping สำหรับเก็บข้อมูลนักเรียน โดยใช้ studentID เป็นคีย์
    mapping(string => Student) private students;

    // Event ที่จะถูกกระตุ้นเมื่อมีการเพิ่มข้อมูลนักเรียน
    event StudentAdded(
        string studentID, 
        string firstName, 
        string surname, 
        string houseNumber, 
        string streetName, 
        string city, 
        string postcode
    );

    // ฟังก์ชันสำหรับตรวจสอบรหัสนักศึกษา
    function isValidID(string memory studentID) internal pure returns (bool) {
        // ตรวจสอบความยาวของรหัสนักศึกษา
        if (bytes(studentID).length != 8) {
            return false;
        }

        // ตรวจสอบตัวอักษรแรกต้องเป็น B, M หรือ D
        bytes1 level = bytes(studentID)[0];  
        if (level != 'B' && level != 'M' && level != 'D') {
            return false;
        }

        // คำนวณ checksum 
        uint checksum = (uint(uint8(bytes(studentID)[1])) - 48) * 49 +
                        (uint(uint8(bytes(studentID)[2])) - 48) * 7 +
                        (uint(uint8(bytes(studentID)[3])) - 48) * 49 +
                        (uint(uint8(bytes(studentID)[4])) - 48) * 7 +
                        (uint(uint8(bytes(studentID)[5])) - 48) * 49 +
                        (uint(uint8(bytes(studentID)[6])) - 48) * 7;
        checksum = checksum % 10;

        // ตรวจสอบตัวเลขสุดท้าย
        uint lastDigit = uint(uint8(bytes(studentID)[7])) - 48;
        return checksum == lastDigit;
    }

    // ฟังก์ชันสำหรับเพิ่มข้อมูลนักเรียน
    function addStudent(
        string memory studentID,
        string memory firstName,
        string memory surname,
        string memory houseNumber,
        string memory streetName,
        string memory city,
        string memory postcode
    ) public {
        // ตรวจสอบรหัสนักศึกษาก่อน
        require(isValidID(studentID), "Invalid student ID");

        // เพิ่มข้อมูลนักเรียนลงใน Mapping
        students[studentID] = Student({
            studentID: studentID,
            firstName: firstName,
            surname: surname,
            houseNumber: houseNumber,
            streetName: streetName,
            city: city,
            postcode: postcode
        });

        // Emit Event เมื่อเพิ่มข้อมูลนักเรียน
        emit StudentAdded(
            studentID, 
            firstName, 
            surname, 
            houseNumber, 
            streetName, 
            city, 
            postcode
        );
    }

    // ฟังก์ชันค้นหาข้อมูลนักเรียน พร้อมกับการแสดงรหัสนักศึกษาด้วย
    function getStudent(string memory studentID) public view returns (
        string memory id,
        string memory firstName,
        string memory surname,
        string memory houseNumber,
        string memory streetName,
        string memory city,
        string memory postcode
    ) {
        // ดึงข้อมูลนักเรียนจาก Mapping
        Student memory student = students[studentID];

        // ส่งคืนข้อมูลนักเรียนพร้อมกับรหัสนักศึกษา
        return (
            student.studentID,
            student.firstName,
            student.surname,
            student.houseNumber,
            student.streetName,
            student.city,
            student.postcode
        );
    }
}
