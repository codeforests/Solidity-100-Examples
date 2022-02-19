//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./StructDeclaration.sol";

contract ToDos {

    //an array of custom struct
    ToDo[] public tasks;

    //adding new item
    function createTask(uint8 _priority, string memory _text) public {
        tasks.push(ToDo({priority : _priority, text : _text, completed : false}));
        
        tasks.push(ToDo(_priority+1, _text, false));
        
        ToDo memory d;
        d.priority = _priority + 2;
        d.text = _text;
        d.completed = false;
        tasks.push(d);

    }

    //retrieve a struct item
    function get(uint _index) public view returns (uint8 priorty, string memory text, bool completed) {
        ToDo memory todo = tasks[_index];
        return(todo.priority, todo.text, todo.completed);
    }

    //update a struct item (by using the `storage` data location)
    function update(uint _index, uint8 _priority, string memory _text) public {
        ToDo storage todo = tasks[_index];
        todo.text = _text;
        todo.priority = _priority;
    }

    //update attribute of the struct
    function markAsCompleted(uint _index) public {
        ToDo storage todo = tasks[_index];
        todo.completed = true;
    }
}