// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistry {
    // Define the Student structure
    struct Student {
        uint256 id;
        string name;
        string grade;
    }

    // Mapping to store students (id -> Student)
    mapping(uint256 => Student) private students;

    // Event emitted when a student is added
    event StudentAdded(uint256 id, string name, string grade);

    /**
     * Adds a new student to the registry
     * @param _id Unique identifier for the student
     * @param _name Student's full name
     * @param _grade Student's grade level
     */
    function addStudent(
        uint256 _id,
        string memory _name,
        string memory _grade
    ) public {
        // Check if student already exists
        require(students[_id].id != _id, "Student already exists");

        // Create and store the student
        students[_id] = Student(_id, _name, _grade);

        // Emit event to notify of student addition
        emit StudentAdded(_id, _name, _grade);
    }

    /**
     * Retrieves a student's information by ID
     * @param _id Student's unique identifier
     * @return Student object containing student's details
     */
    function getStudent(uint256 _id) public view returns (
        uint256,
        string memory,
        string memory
    ) {
        // Get the student from storage
        Student storage student = students[_id];

        // Verify student exists
        require(student.id == _id, "Student not found");

        return (student.id, student.name, student.grade);
    }
}