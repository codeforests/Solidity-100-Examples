//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Mapping {
    mapping(address => uint) public mymap;

    function get(address _address) public view returns (uint) {
        return mymap[_address];
    }

    function set(address _address, uint _i) public {
        mymap[_address] = _i;
    }

    function remove(address _address) public {
        delete mymap[_address];   
    }
}

contract NestedMapping {

    mapping(address => mapping(uint => bool)) public nested;

    function get(address _address, uint _i) public view returns(bool) {
        return nested[_address][_i];
    }

    function set(
        address _address,
        uint _i,
        bool _bool) public  {
            nested[_address][_i] = _bool;
    }

    function remove(address _address, uint _i) public {
        delete nested[_address][_i];
    }
}