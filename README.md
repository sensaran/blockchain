# block-chain
Block-chain

### Question 1 Hello World
Create a Solidity contract named HelloWorld that contains a string variable greeting
initialized with "Hello, Ethereum!". Include a public function getGreeting() that
returns the value of greeting.
**Expected Output:** On deploying the contract, any user can call getGreeting() and
receive the greeting message.

### Question 2 Counter
Create a Solidity contract named Counter that initializes an integer counter to zero. The
contract should have two functions: one to increment the counter by one and another to
return the current count.
**Expected Output:** After deployment, calling the increment function multiple times
should increase the counter value accordingly. Calling the view function should return
the latest value of the counter.

### Question 3 Boolean Toggle
Create a Solidity contract named LightSwitch with a boolean variable isOn initialized
to false. The contract should have:
• A function toggle() that switches the value of isOn between true and false
• A function status() that returns the current state of isOn
**Expected Output:** After deployment, calling toggle() should flip the value of isOn.
Calling status() should return either true or false based on the toggle state.

### Question 4 Simple Wallet
Create a Solidity contract named SimpleWallet that allows users to send and store Ether.
The wallet should allow only the owner (set at the time of deployment) to withdraw the
stored Ether. The contract should also include a public function to check the contract’s
current balance.
• Users send Ether to the contract using the receive() function
• Owner withdraws using withdraw()
• getBalance() returns the current contract balance
**Expected Output:** Users can deposit Ether. Only the owner can withdraw. The
balance is visible via getBalance().

### Question 5 Restricted Data
Write a contract RestrictedData that stores a secret unsigned integer data. The contract
should restrict modifications to this data only to the contract deployer.
• The owner sets data using setData()
• getData() is accessible by anyone
**Expected Output:** Only the owner can change the data; anyone can view it.

### Question 6 Student Registry
Create a contract StudentRegistry to store and manage student records.
• Use a Student struct with fields: id, name, grade
• Store students using a mapping from ID to Student
• Add functions to add and retrieve students
**Expected Output:** After adding students, their data can be retrieved using the ID.

### Question 7 Voting System
In democratic organizations and decentralized communities, voting is a critical part of
decision-making. This problem simulates such a scenario using smart contracts. The
voting process is controlled by an admin and ensures that each address can vote only
once, and the final outcome is publicly verifiable.
Create a contract VotingSystem that supports a basic decentralized voting mechanism.
• Admin starts/ends voting
• Each address can vote once
• Voting options are "Yes" and "No"
• The final tally is shown after voting ends
**Expected Output:** Each address can vote once. Admin can end voting and show
results.

### Question 8 Crowdfunding Contract
Crowdfunding is a popular method for entrepreneurs to raise capital from a large number
of people via the internet. Blockchain can bring transparency and accountability to this
model. This smart contract allows contributors to support a project until a deadline. If the funding goal is met, the project owner can collect the funds. Otherwise, contributors
are eligible for refunds.
Create a contract Crowdfund to simulate a real-world crowdfunding campaign.
• Accepts ETH until a specified deadline
• If the funding goal is reached, the owner withdraws
• If not, contributors can request refunds
**Expected Output:** If the goal is met, owner can withdraw. Otherwise, users can get
refunds.

### Question 9 Certificate Issuer
Blockchain-based academic certification is an emerging solution to prevent document
forgery and simplify the verification process for employers and institutions. This contract
simulates a university that issues immutable certificates to students. These certificates
are publicly verifiable and tamper-proof.
Create a contract CertificateIssuer to simulate a blockchain-based certificate verification
system.
• Only the university can issue certificates
• Each certificate includes name, course, and issue date
• Certificates are stored in a mapping from student ID
• Verifiers can retrieve certificate details using student ID
**Expected Output**: University can issue certificates. Anyone can verify using student
ID.

### Question 10 Animal Inheritance
Create a base contract Animal with a virtual function speak() that returns a generic
sound. Inherit this contract in a derived contract Dog that overrides speak() to return
"Woof".
Expected Output: Calling speak() on the Dog contract should return "Woof".
