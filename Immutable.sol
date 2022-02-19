//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

/**
    1) value assignment for immutable variable can only happens at declaration line
    or inside constructor function
    2) if value assigned at declaration line, it is equivalent to constant variable
    3) declare variable inside a function with the same name as 
    immutable variable will shadow the immutable variable
 */

contract Immutable {

    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;
    uint public immutable my_uint2 = 456;
    uint public constant my_uint3 =  456;


    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }

    function changeIt() public view {
        //shadows the immutable Variable
        address MY_ADDRESS = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    }

}