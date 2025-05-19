// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint counter;

    constructor(){
        counter = 0;
    }

    function incrementCounter() public  {
        counter++;
    }

    function getCounter() public view returns (uint){
        return counter;
    }

}
