// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Animal {
    function speak() virtual public pure returns (string memory) {
        return "Generic animal sound";
    }
}

contract Dog is Animal {
    function speak() override public pure returns (string memory) {
        return "Woof";
    }
}

// Example usage (requires deploying Dog separately and passing its address)
contract AnimalDemo {
    Dog public myDog; // Store the Dog contract address

    constructor(Dog _dogAddress) {
        myDog = _dogAddress;
    }

    function getDogSound() public view returns (string memory) {
        return myDog.speak();
    }
}