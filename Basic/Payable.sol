//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PayableContract {

    address payable public owner;

    modifier OnlyOwner {
        require(msg.sender == owner, "Only owner is allowed");
        _;
    }

    //you can send some ether when deploying contract 
    constructor() payable {
        owner = payable(msg.sender);
    }

    //call with some ethers, contract balance is updated automatically
    function depositEthers() public payable {}

    //receive or fallback must be defined when using send/transfer/call to send ether
    //receive() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    //fails when calling with ETH
    function depositTwoETH() external {

    }

    //transaction still fails when no receive/fallback function defined
    function depositETH(uint256 _amount) external payable {
        (bool success, ) = payable(address(this)).call{value: _amount}("");
        require(success, "Failed to deposit ETH to this contract");
    }

    //owner can receive ether as it is payable
    function withdraw(uint256 _amount) public OnlyOwner {
        uint _balance = address(this).balance;
        require(_amount <= _balance, "Insufficient balance!");
        (bool success, ) = owner.call{value: _amount}("");
        require(success, "Failed to send ETH");
    }

    //_to can receive ether since it is payable
    function transfer(address payable _to, uint256 _amount) public OnlyOwner {
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send ETH");
    }



}