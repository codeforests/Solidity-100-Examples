//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract simple_contract {

    //human-readable format
    uint256 big_number = 1000_000_000_000;
    //this is compilable
    string string_var = "this is \
    fine";

    uint256 num = uint256(0);

    event Received(address, uint);

    constructor () {
        console.log(big_number);
        console.log(string_var);
    }

    function getNum() external view returns(uint256) 
    {
        return (num - 1);
    }

    function deposit() public payable {
        //msg.value automatically updated to contract balance
        console.log(address(this).balance);
    }

    function get_balance() external view returns(uint256) {
        return address(this).balance;
    }

    receive() external payable {
        console.log("ether received");
        emit Received(msg.sender, msg.value);
    }
}
