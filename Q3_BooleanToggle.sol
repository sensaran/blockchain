// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LightSwitch{
    bool isOn;
    constructor(){
        isOn = false;
    }

    function toggle() public {
        isOn = !isOn;
    }

    function status() public view returns(bool){
        return isOn;
    }

}