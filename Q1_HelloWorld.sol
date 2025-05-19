
// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

contract HelloWorld{
    string greetings;
    constructor (){
        greetings = "Hello, Ethereum!";
    }
    function getGreeting () public view returns(string memory){
        return greetings;
    }
}
