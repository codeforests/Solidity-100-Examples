//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; 

contract Callee {
    
    address public owner;

    //address cannot be 0 or 0x0000000000000000000000000000000000000001
    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function checker(uint _x) public pure returns (uint) {
        require(_x > 5, "Input must be greater than 5!");
        return (_x + 1);
    }

}

contract Caller {

    event Log(string message);
    event LogInt(uint n);
    event LogBytes(bytes data);
    event LogAddress(address _addr);
    uint public state;
    
    //with try & catch, state value will not be reverted when function call failed
    function tryCatch(uint _x) public {
        state = _x;

        Callee callee = new Callee(msg.sender);

        try callee.checker(_x) returns (uint result)
        {
            emit LogInt(result);
        } catch {
            emit Log("Callee.checker function call failed.");
        }
    }

    //state value reverted when function call failed
    function withoutTryCatch(uint _x) public {
        state = _x;
        Callee callee = new Callee(msg.sender);
        uint result = callee.checker(_x);
        emit LogInt(result);
    }

    function tryCatchNewContract(address _owner) public {

        try new Callee(_owner) returns (Callee c) {
            emit LogAddress(c.owner());
            emit Log("Callee created!");
        } catch Error(string memory reason) {
            //catch failing for revert or require
            emit Log(reason);
        } catch (bytes memory reason) {
            //catch failing for assert failure
            emit LogBytes(reason);
        }
    }

}