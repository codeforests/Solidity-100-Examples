//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./String.sol";

/**
    External - Always use external when you do not want to call the function from within 
    the same contract. This will save some gas as it does not copy the calldata into memory.

    Public - Use public for publicly accessible state variables and the functions to be
    accessible from the outside and inside.

    Internal - Use internal when state variables and functions should also be accessible in 
    child contracts

    Private - Use private to protect your state variables and functions as you can hide them 
    behind logic executed through internal or public functions.


 */

contract Base {

    //accessible by current contract
    string private privateVar = "this is private";

    //accessible by all contracts, a publicVar() getter function is auto generated
    string public publicVar = "this is public";

    //accessible by current and child contracts
    string internal interalVar = "this is internal";
    string interalVar2 = "this is another internal variable";

    //private function only can be called in current contract
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();        
    }

    //internal function only can be called in current contract or child contracts
    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    //public function can be called internally or externally
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    //external function only can be called externally
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    function test() public pure returns(string memory) {
        string memory x = testInternalFunc();

        return x;
    }

 

}

contract Child is Base {

    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }

    function testInternalVar() public view returns (string memory) {
        return interalVar;
    }

    function testPublicVar() public view returns (string memory) {
        return publicVar;
    }

}

contract Others {

    Base baseContract;

    constructor(address _contract) {
        baseContract = Base(_contract);
    }

    //compiler error as internal function is not accessible
    // function testInternalFunc() public view returns (string memory) {
    //     return baseContract.internalFunc();
    // }
    
    //compiler error as internal function is not accessible
    // function testInternalVar() public view returns (string memory) {
    //     return baseContract.interalVar;
    // }


    function testPublicVar() public view returns (string memory) {
        return baseContract.publicVar();
    }

}