//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

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

    receive() external payable {}

    fallback() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}


contract SenderContra {

    //to deposit some ETH for testing
    function deposit() external payable {
        
    }

    //using transfer method, not recommended anymore
    function transferETH(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    //using send method, not recommended anymore
    function sendETH(address payable _to) public payable {
        
        bool succ = _to.send(msg.value);
        require(succ, "Failed to send ETH");
    }

    //using call method, recommended way to send ether
    function sendETHCall(address payable _to) public payable {
        
       (bool succ, ) = _to.call{value : msg.value}("");
       require(succ, "Failed to send ETH");
    }
}