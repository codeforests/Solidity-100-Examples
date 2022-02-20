//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract DataLocation {
    uint[] public arr;
    mapping(uint => address) map;
    struct Person {
        string name;
        uint8 age;
    }
    mapping(uint8 => Person) rank;

    function update() public {
        _updateVal(arr, map, rank);

        console.log(arr[0]);
        console.log(map[0]);
        console.log(rank[0].name);

        Person storage p2 = rank[1];
        Person storage p3 = rank[2];

        console.log(p2.name);
        console.log(p3.name);
    }

    function _updateVal(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        mapping(uint8 => Person) storage _r
    ) internal {

        _arr[0] = 1;
        _map[0] = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

        _r[0].name = "ken";
        _r[0].age = 10;

        _r[1].name = "ken1";
        _r[1].age = 11;

        _r[2].name = "ken2";
        _r[2].age = 12;

    }

    function g(uint[] memory _arr) public returns(uint[] memory) {
        _arr[0] = 100;
        console.log(_arr[0]);
        return _arr;
    }

    function h(uint[] calldata _arr) external {
        console.log(_arr[0]);
    }
}