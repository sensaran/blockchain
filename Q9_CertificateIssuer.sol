// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CertificateIssuer {
    // Event emitted when a certificate is issued
    event CertificateIssued(
        string studentId,
        string name,
        string course,
        uint256 issueDate
    );

    // Event emitted when certificate verification occurs
    event CertificateVerified(
        string studentId,
        address verifier
    );

    // Mapping of student IDs to certificates
    mapping(string => Certificate) public certificates;

    // Structure to represent a certificate
    struct Certificate {
        string name;
        string course;
        uint256 issueDate;
    }

    // Only allow university to issue certificates
    modifier onlyUniversity() {
        require(msg.sender == universityAddress, "Only university can issue certificates");
        _;
    }

    address private universityAddress;

    constructor(address _university) {
        universityAddress = _university;
    }

    function issueCertificate(
        string memory _studentId,
        string memory _name,
        string memory _course
    ) external onlyUniversity {
        // Ensure certificate doesn't already exist
        require(
            certificates[_studentId].issueDate == 0,
            "Certificate already exists for this student"
        );

        // Create and store the certificate
        certificates[_studentId] = Certificate({
            name: _name,
            course: _course,
            issueDate: block.timestamp
        });

        emit CertificateIssued(_studentId, _name, _course, block.timestamp);
    }

    function verifyCertificate(string memory _studentId)
        external
        view
        returns (
            string memory name,
            string memory course,
            uint256 issueDate
        )
    {
        require(
            certificates[_studentId].issueDate != 0,
            "No certificate found for this student ID"
        );

        //emit CertificateVerified(_studentId, msg.sender);

        return (
            certificates[_studentId].name,
            certificates[_studentId].course,
            certificates[_studentId].issueDate
        );
    }

    function getUniversityAddress() external view returns (address) {
        return universityAddress;
    }
}