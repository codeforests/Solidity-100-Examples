//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./EnumDeclaration.sol";

contract Enum {

    mapping(uint8 => string) public enumMap;

    DeliveryStatus public status;

    constructor () {
        enumMap[0] = "Pending";
        enumMap[1] = "PickedUp";
        enumMap[2] = "InTransit";
        enumMap[3] = "Delivered";
        enumMap[4] = "Cancelled";
    }

    function get() public view returns (DeliveryStatus) {
        return status;
    }

    function getCurrentStatus() public view returns (string memory) {
        return enumMap[uint8(status)];
    }

    function setNext() external returns(DeliveryStatus) {
        if (uint(status) == 4) {
            reset();
        }
        else {
            status = DeliveryStatus(uint(status) + 1);
        }
        return status;
    }

    function set(DeliveryStatus _status) external returns(bool) {
        status = _status;
        return true;
    }

    function cancel() public {
        status = DeliveryStatus.Cancelled;
    }

    function reset() public {
        delete status;
    }
    
}