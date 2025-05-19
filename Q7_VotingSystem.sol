// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    // Define the possible voting options
    enum Vote { None, Yes, No }
    
    // Track individual votes
    mapping(address => Vote) public votes;
    
    // Store vote counts
    uint256 public yesCount;
    uint256 public noCount;
    
    // Admin address
    address public admin;
    
    // Track if voting is active
    bool public isActive;
    
    // Events for tracking activity
    event VoteCast(address indexed voter, Vote vote);
    event VotingStarted();
    event VotingEnded();
    
    // Constructor - initialize admin and set voting to active
    constructor() {
        admin = msg.sender;
        isActive = true;
    }
    
    // Modifier to restrict access to admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }
    
    // Modifier to ensure voting is active
    modifier onlyDuringVoting() {
        require(isActive, "Voting is not active");
        _;
    }
    
    // Start voting session
    function startVoting() external onlyAdmin {
        require(!isActive, "Voting is already active");
        isActive = true;
        emit VotingStarted();
    }
    
    // End voting session
    function endVoting() external onlyAdmin {
        require(isActive, "Voting is not active");
        isActive = false;
        emit VotingEnded();
    }
    
    // Cast a vote
    function vote(bool _yes) external onlyDuringVoting {
        // Get current vote status
        Vote currentVote = votes[msg.sender];
        
        // Ensure voter hasn't already voted
        require(currentVote == Vote.None, "Address has already voted");
        
        // Update vote counts
        if (_yes) {
            votes[msg.sender] = Vote.Yes;
            yesCount++;
        } else {
            votes[msg.sender] = Vote.No;
            noCount++;
        }
        
        emit VoteCast(msg.sender, votes[msg.sender]);
    }
    
    // View function to get results
    function getResults() external view returns (uint256 yesVotes, uint256 noVotes) {
        require(!isActive, "Voting is still active");
        return (yesCount, noCount);
    }
}