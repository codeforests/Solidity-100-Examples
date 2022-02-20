//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./EnumDeclaration.sol";

contract Enum {

    //map of integer to Enum string
    mapping(uint8 => string) public enumMap;
    
    //state variable with Enum data type
    DeliveryStatus public status;

    constructor () {
        //initialize the mapping
        enumMap[0] = "Pending";
        enumMap[1] = "PickedUp";
        enumMap[2] = "InTransit";
        enumMap[3] = "Delivered";
        enumMap[4] = "Cancelled";
    }

    //returns 0, 1, 2 ...
    function get() public view returns (DeliveryStatus) {
        return status;
    }

    //convert status as string
    function getCurrentStatus() public view returns (string memory) {
        return enumMap[uint8(status)];
    }

    //Enum status transition
    function setNext() external returns(DeliveryStatus) {
        if (uint(status) == 4) {
            reset();
        }
        else {
            status = DeliveryStatus(uint(status) + 1);
        }
        return status;
    }

    //set enum by index
    function set(DeliveryStatus _status) external returns(bool) {
        status = _status;
        return true;
    }

    //better way to assign value to enum variable
    function cancel() public {
        status = DeliveryStatus.Cancelled;
    }

    //set to initial state which is 0
    function reset() public {
        delete status;
    }
    
}