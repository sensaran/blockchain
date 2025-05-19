// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    // State variable to store the owner address
    address private immutable owner;
    
    // Event emitted when Ether is received
    event Received(address indexed sender, uint256 amount);
    
    // Event emitted when owner withdraws Ether
    event Withdrawal(address indexed to, uint256 amount);
    
    
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * Emits a Received event when Ether is deposited
     */
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    
    /**
     * Allows the owner to withdraw all Ether from the contract
     * @param _to The address where the Ether will be sent
     */
    function withdraw(address payable _to) external {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(_to != address(0), "Invalid withdrawal address");
        
        uint256 amount = address(this).balance;
        require(amount > 0, "No balance to withdraw");
        
        _to.transfer(amount);
        emit Withdrawal(_to, amount);
    }
    
    /**
     * Returns the current balance of the contract
     * @return uint256 The current balance in Wei
     */
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}