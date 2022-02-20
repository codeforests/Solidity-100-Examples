//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner!");
        _;
    }

    //for receiving ether
    receive() external payable {}

    //only owner can withdraw fund
    function withdraw(uint _amount) public onlyOwner{
        require(_amount <= address(this).balance, "Insufficient balance!");
        (bool succ, ) = owner.call{value : _amount}("");
        require(succ, "withdrawal transaction failed!");
    }

    function getBalance() public view returns (uint balance) {
        balance = address(this).balance;
    }

}