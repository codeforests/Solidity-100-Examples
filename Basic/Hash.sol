//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
Hash function is an algorithm that takes an arbitrary amount of data as input 
and produces the encrypted text of fixed size. Even a slight change in the input 
gives a completely different output.

The keccak256 function in the below example returns a bytes32 string.

 */

contract Hashing {

    //generate hash for a list of arguments
    function hash(
        string memory _name, 
        uint _age, 
        bool _whitelisted,
        address _address) public pure returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                _name, 
                _age, 
                _whitelisted,
                _address));
    }

    function collide(string memory _user, string memory _password) public pure returns (bytes32) {
        // abi.encodePacked using unpadded encoding which leads to hash collision e.g.: test, 123 vs test1, 23
        return keccak256(
            abi.encodePacked(_user, _password)
        );
    }

    
    function nonCollision(string memory _user, string memory _password) public pure returns (bytes32) {
        //abi.encode properly pads byte arrays and strings from calldata
        return keccak256(
            abi.encode(_user, _password)
        );
    }

    function testCollision() public pure returns (bool, bool) {
        //causing hash collision
        bytes32 hash1 = collide("test", "12");
        bytes32 hash2 = collide("test1", "2");
        
        bytes32 hash3 = nonCollision("test", "12");
        bytes32 hash4 = nonCollision("test1", "2");

        return (hash1 == hash2, hash3 == hash4);
    }
}