//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
    Event and its parameters are captured in the transaction logs and visible on blockchain
 */

contract Event {

    //`sender` will be captured as topic instead of log data, to faciliate the event filtering
    event Log(address indexed sender, string message);
    //all info is captured in data part of the log when not indexed
    event FunctionExecuted(string message);

    function logEvent() public {
        //use emit to fire the event
        emit Log(msg.sender, "who are you?");
        emit Log(msg.sender, "tell me");
        emit FunctionExecuted("That is the end!");
    }
}