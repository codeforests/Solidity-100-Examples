//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

enum DeliveryStatus {
        Pending,
        PickedUp,
        InTransit,
        Delivered,
        Cancelled
    }