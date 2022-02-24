//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//interface
interface ICounter {

    function count() external view returns (uint) ;
    function increment() external;
    function decrement() external;
}

//contract that implements the interface 
contract Counter {
    uint256 public count;

    function increment() external {
        unchecked {
            count += 1;
        }
    }

    function decrement() external {
        require(count > 0, "Counter: decrement overflow");
        unchecked {
            count -= 1;
        }
    }

    function reset() external {
        count = 0;
    }
}

//using interface in contract
contract Countable {
    ICounter private counter;
    
    function setCounterAddress(address _counter) external {
        require(_counter != address(0), "invalid address");
        counter = ICounter(_counter);
    }
    function incrementCounter() external {
        counter.increment();
    }
    function getCount() external view returns (uint) {
        return counter.count();
    }

    function decrement() external {
        counter.decrement();
    }

}