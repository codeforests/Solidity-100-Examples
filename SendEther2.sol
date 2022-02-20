//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Receivable {

    /*
    flow of the fallback() or receive() to be called:

            send ETH
                |
            msg.data is empty?
                / \
                yes  no
                /     \
    receive() exists?  fallback()
            /   \
            yes   no
            /      \
        receive()   fallback()
    */

    function deposit() external payable {
        console.log("receivable deposit called");
        console.log(msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}

interface IReceivable {
    function deposit() external payable;
    function getBalance() external view returns (uint256);
}

contract SenderContra {

    /*
    this is just for exploring the hard way to send ETH from one contract to
    another without using send, transfer or call method.
    */

    //to deposit some ETH for testing
    function deposit() external payable {
        
    }

    //forward ether from current contract to the receivable contract
    function depositETH(IReceivable _contract) public payable {        
        console.log(msg.value);
        IReceivable(_contract).deposit{value : msg.value}();
        console.log("SenderContra deposit finished!");
    }

    //load the receivable contract and interact with it
    function fundContract(address _addr) public payable {
        console.log(msg.value);
        Receivable _contract = Receivable(_addr);
        _contract.deposit{value : msg.value}();
        console.log("fundContract finished!");

    }
}