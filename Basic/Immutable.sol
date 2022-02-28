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

    address private immutable original;
    uint public immutable MY_UINT;
    uint public immutable my_uint2 = 456;
    uint public constant my_uint3 =  456;


    constructor(uint _myUint) {
        //assign contract address to variable original
        original = address(this);
        MY_UINT = _myUint;
    }

    function changeIt() public view {
        //shadows the immutable Variable
        uint256 MY_UINT = 12;

    }

    //a method to prevent delegate calls 
    function checkNotDelegateCall() private view {
        require(address(this) == original);
    }

}