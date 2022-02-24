//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
    Below code demonstrates how to use call function to interact with the functions from 
    another contract. When the calling function does not exist, the fallback function will
    be triggered
 */

contract ReceiverContra {
    event Received (address caller, uint256 amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "fallback is triggered");
    }

    function pay(string memory _message, uint256 _receiptNo) public payable returns(string memory) {
        emit Received(msg.sender, _receiptNo, _message);
        return "Thank You";
    }
}

contract SenderContra {
    event Response(bool success, bytes data);

    function deposit() external payable {}

    //the pay function from ReceiverContra will be called
    function callPay(address payable _addr) public payable {
        (bool succ, bytes memory data) = _addr.call{
            value : msg.value, 
            gas: 6000 }(
                abi.encodeWithSignature(
                    "pay(string, uint256)", 
                    "pay you for lunch", 
                    11223311)
            );
        emit Response(succ, data);
    }

    //the fallback function from ReceiverContra will be triggered when the calling function does not exist
    function callNonExisitingFunc(address _addr) public {
        (bool succ, bytes memory data) = _addr.call(
            abi.encodeWithSignature("abc()")
        );

        emit Response(succ, data);
    }

}