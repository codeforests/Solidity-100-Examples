//SPDX-License-Identifier: MIT;

pragma solidity ^0.8.0;

import "hardhat/console.sol";

/*
    1) constant variable cannot be changed once its initialized.
    2) value assignment must be at declaration line, otherwise thowing compiling error
    3) declare variable inside a function with the same name as 
    constant variable will shadow the constant variable
*/

contract Constants {

    address public constant MY_ADDRESS = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    uint public constant MY_UINT = 123;

    function changeConstant() public view {
       //it does not change the constant, rather created a local variable
       address MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
       uint MY_UINT = 345;
       
       console.log(MY_ADDRESS);
       console.log(MY_UINT);

    }
}