// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RestrictedData {
    // Store the owner who deployed the contract
    address private owner;
    
    // Store the secret data
    uint256 private data;
    
    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can modify data");
        _;
    }
    
    // Constructor to set initial owner
    constructor() {
        owner = msg.sender;
    }
    
    // Function to set the data (owner only)
    function setData(uint256 _newData) public onlyOwner {
        data = _newData;
    }
    
    // Function to get the data (everyone can call)
    function getData() public view returns (uint256) {
        return data;
    }
}