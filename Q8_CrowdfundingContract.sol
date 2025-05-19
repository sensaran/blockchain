// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfund {
    // Structure to store campaign information
    struct Campaign {
        address creator;
        uint256 goal;
        uint256 deadline;
        uint256 amountRaised;
        bool isWithdrawn;
        mapping(address => uint256) contributions;
    }

    // Mapping of campaign IDs to their details
    mapping(uint256 => Campaign) public campaigns;
    
    // Current campaign ID counter
    uint256 public campaignCount = 0;

    // Events for tracking important actions
    event CampaignCreated(
        uint256 indexed campaignId,
        address indexed creator,
        uint256 goal,
        uint256 deadline
    );

    event ContributionMade(
        uint256 indexed campaignId,
        address indexed contributor,
        uint256 amount
    );

    event FundsWithdrawn(
        uint256 indexed campaignId,
        uint256 amount
    );

    event RefundIssued(
        uint256 indexed campaignId,
        address indexed contributor,
        uint256 amount
    );

    // Create a new campaign
    function createCampaign(uint256 _goal, uint256 _duration) external {
        require(_goal > 0, "Goal must be greater than zero");
        require(_duration > 0, "Duration must be greater than zero");

        // Create new campaign
        Campaign storage newCampaign = campaigns[campaignCount];
        newCampaign.creator = msg.sender;
        newCampaign.goal = _goal;
        newCampaign.deadline = block.timestamp + _duration;

        emit CampaignCreated(campaignCount, msg.sender, _goal, newCampaign.deadline);
        campaignCount++;
    }

    // Contribute to a campaign
    function contribute(uint256 _campaignId) external payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        require(_campaignId < campaignCount, "Invalid campaign ID");
        require(block.timestamp <= campaigns[_campaignId].deadline, 
            "Campaign deadline has passed");

        Campaign storage campaign = campaigns[_campaignId];
        campaign.amountRaised += msg.value;
        campaign.contributions[msg.sender] += msg.value;

        emit ContributionMade(_campaignId, msg.sender, msg.value);
    }

    // Withdraw funds if goal is reached
    function withdrawFunds(uint256 _campaignId) external {
        require(_campaignId < campaignCount, "Invalid campaign ID");
        Campaign storage campaign = campaigns[_campaignId];

        require(msg.sender == campaign.creator, "Only creator can withdraw");
        require(block.timestamp >= campaign.deadline, "Campaign deadline not reached");
        require(campaign.amountRaised >= campaign.goal, "Funding goal not reached");
        require(!campaign.isWithdrawn, "Funds already withdrawn");

        uint256 amount = campaign.amountRaised;
        campaign.isWithdrawn = true;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");

        emit FundsWithdrawn(_campaignId, amount);
    }

    // Request refund if campaign failed
    function requestRefund(uint256 _campaignId) external {
        require(_campaignId < campaignCount, "Invalid campaign ID");
        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp >= campaign.deadline, "Campaign deadline not reached");
        require(campaign.amountRaised < campaign.goal, "Campaign succeeded");
        require(campaign.contributions[msg.sender] > 0, "No contributions found");

        uint256 contribution = campaign.contributions[msg.sender];
        campaign.contributions[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: contribution}("");
        require(sent, "Failed to send Ether");

        emit RefundIssued(_campaignId, msg.sender, contribution);
    }
}