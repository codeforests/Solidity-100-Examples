//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./StructDeclaration.sol";

contract ToDos {

    ToDo[] public tasks;

    function createTask(uint8 _priority, string memory _text) public {
        tasks.push(ToDo({priority : _priority, text : _text, completed : false}));
        
        tasks.push(ToDo(_priority+1, _text, false));
        
        ToDo memory d;
        d.priority = _priority + 2;
        d.text = _text;
        d.completed = false;
        tasks.push(d);

    }

    function get(uint _index) public view returns (uint8 priorty, string memory text, bool completed) {
        ToDo storage todo = tasks[_index];
        return(todo.priority, todo.text, todo.completed);
    }

    function update(uint _index, uint8 _priority, string memory _text) public {
        ToDo memory todo = tasks[_index];
        todo.text = _text;
        todo.priority = _priority;
    }

    function markAsCompleted(uint _index) public {
        ToDo storage todo = tasks[_index];
        todo.completed = true;
    }
}