//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Variables {

    //state variables
    //uint256
    uint public num = 123;
    //int256 
    int public temperature = -10;
    //boolean
    bool public completed = false;
    //Fixed-size Byte Arrays
    bytes1 public symbol = "c";
    //address (=>bytes20)
    address private owner;

    //dynamically-sized UTF-8-encoded string
    string public text = "hello";
    //dynamically-sized byte array 
    bytes public bytecode;

    constructor () public {
        owner = msg.sender;
    }

    function doIt() public view {
        //local variables within function scope
        uint i = 456;

        //global variables such as block.timestamp, msg.value, msg.sender etc.
        uint timestamp = block.timestamp;
        address sender = msg.sender;

        console.log(i);
        console.log(timestamp);
        console.log(sender);

        //local variable does not save changes
        uint after30days = timestamp + 30 days;
        console.log(after30days);

        completed = true;
    }

    function getBytecode() public{
        bytecode = abi.encodeWithSignature("doIt()");
    }
}