//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SaftMath {
    function add(uint x, uint y) internal pure returns (uint) {
        uint z = x + y;
        require(z >= x, "uint overflow!");
        return z;
    }
}

library Math {
    function sqrt(uint y) internal pure returns (uint r) {
        if (y > 3) {
            r = y;
            uint x = y / 2 + 1;
            while (x < r) {
                r = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            r = 1;
        }
        // else r = 0 (default value)
    }
    
}

library Array {
    function remove(uint[] storage arr, uint index) public {
        require(arr.length > 0, "Array is empty!");
        //put the last element into the place of the deleted element
        arr[index] = arr[arr.length - 1];
        //remove the last element with delete or pop
        delete arr[arr.length - 1];
        //arr.pop();
    }
}

contract TestLib {
    using SaftMath for uint;
    uint public MAX_UINT = 2 ** 256 - 1;

    uint[] public arr;
    using Array for uint[];

    function testAdd(uint x, uint y) public pure returns (uint) {
        return x.add(y);
    }

    function testSQRT(uint x) public pure returns (uint) {
        return Math.sqrt(x);
    }

    function testArray() public {
        for(uint x = 0; x < 10; x++)
        {
            arr.push(x);
        }

        arr.remove(0);
        assert(arr.length == 9);
        assert(arr[0] == 9);
        assert(arr[1] == 1);
    }
}