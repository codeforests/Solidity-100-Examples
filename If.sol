//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract IfElse {

    function print(uint _n) public pure returns (uint) {
        
        if (_n < 10) {
            return 0;
        } else if (_n < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint _n) public pure returns (uint) {
        return _n < 10 ? 1 : 2;
    }

    function forloop() public pure {

        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
        }

        uint j;

        while (j < 10) {
            j++;
        }

    }
}