//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./String.sol";

contract Base {

    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();        
    }

    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    function test() public pure returns(string memory) {
        string memory x = testInternalFunc();

        return x;
    }

    string private privateVar = "this is private";
    string public publicVar = "this is public";
    string internal interalVar = "this is internal";

}

contract Child is Base {

    // function testInternalFunc() public pure override returns (string memory) {
    //     return super.internalFunc();
    // }

    function test(uint _id) public pure returns (string memory) {
        string memory output =  string(abi.encodePacked(toString(_id), internalFunc()));
        return output;
    }
}