//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract A {
    string public name;

    constructor(string memory _name) {
        name = _name;
        console.log("A:", name);
    }
}

contract B {
    string public text;
    constructor(string memory _text) {
        text = _text;
        console.log("B:", text);
    }
}

//C inherited from A & B. Passing constructor arguments at declaration line
contract C is A("Python"), B("Programming Language") {

    constructor() {
        console.log("This is C!");
    }
}

//D inherited from A & B. Passing parameters to parents' constructor 
contract D is A, B {
    constructor(string memory _name, string memory _text) A(_name) B(_text) {
        console.log("This is D");
    }
}

//E inherited from A & B. 
contract E is A, B {

    //at constructing time
    constructor() A("Java") B("Object Oriented") {
        console.log("this is E");
    }
}

contract F is A, B {

    //sequence does not matter
    constructor() B("On the rails") A("Ruby") {
        console.log("this is F");
    }
}