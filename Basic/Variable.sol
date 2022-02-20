//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Variables {

    //state variables
    //uint256 <=> uint
    uint public num = 123;
    uint8 public u8 =1;

    //int256 <=> int
    int public temperature = -10;
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    int8 public i8 = -1;

    //boolean; default as false
    bool public completed;
    //Fixed-size Byte Arrays
    bytes1 public symbol = "c";
    bytes1 b = 0x11;

    //address (=>bytes20), default as address(0)
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