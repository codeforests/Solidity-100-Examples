//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Func {

    function FuncWithMultipleReturns() public view returns (bool, string memory) {
        //do something

        bool success = true;
        string memory output = string(
            abi.encodePacked(block.timestamp, "@hello world!")
            );
        return (success, output);
    }

    function FuncWithNamedReturns() public view returns(bool success, string memory output) {

        //do something
        success = false;
        output = string(abi.encodePacked("Unexpected error @", block.timestamp));
        return (success, output);
    }

    function FuncWithNamedOutputWithoutReturns() public view returns(
        bool success, string memory output) {
        //do something
        success = false;
        output = string(abi.encodePacked("Unexpected error @", block.timestamp));
    }

    function destructingFromFuncReturn() public view returns(bool, string memory) {
        (bool success, ) = FuncWithMultipleReturns();
        string memory newOutput = string(abi.encodePacked("hello from destructing func at ", block.timestamp));
        return(success, newOutput);
    }

    function FuncWithArrayArgs(uint256[] memory arr) public pure returns(bool) {
        uint n = arr.length;
        arr[n] = 111;
        return true;
    }

    function FuncWithArrayOutput() public pure returns(uint256[] memory arr) {
        arr[0] = 1;
        arr[1] = 2;

        return arr;

    }

}