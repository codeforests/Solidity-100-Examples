//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


/**
REVERT will undo all state changes, and refund any remaining gas to the caller, meanwhile it allows you to 
return values.

REQUIRE is equivalent to REVERT(`error string`) but with a simpler syntax. Bett

ASSERT will undo all the state changes but without refund the remaining gas. It should be only used to prevent
very bad things happening e.g. zero devision, index out of range etc.


Reference: https://ethereum.stackexchange.com/questions/15166/difference-between-require-and-assert-and-the-difference-between-revert-and-thro

 */
contract Revert {

    mapping(address => uint256) accounts;

    //custom error with arguments
    error AgeRequirementNotMet(uint256 minAge);
    error InsufficentBalance(uint256 balance, uint256 withdrawAmount);
    //custom error without arguments
    error InsufficientDeposit();

    function createAccount(uint256 age) public payable {
        if (age < 18) {
            //return without any error data
            revert();
        }
        accounts[msg.sender] = msg.value;
    }

    function openAccount(uint256 age) public payable {
        if (age < 18) {
            //return with a string error
            revert("age requirement not met");
        }
        accounts[msg.sender] = msg.value;
    }

    function testWithdraw(uint256 _withdrawAmount) public view {
        uint bal = address(this).balance;
        if(bal < _withdrawAmount) {
            revert InsufficentBalance({balance : bal, withdrawAmount : _withdrawAmount});
        }
    }

    function registerAccount(uint256 age) public payable {
           
        if (age < 18) {
            //return with a value
            revert AgeRequirementNotMet(18);
        }

        if (msg.value < 0.1 ether) {
            //cheaper way using function signature (four bytes) than passing a error string
            revert InsufficientDeposit();
        }
        accounts[msg.sender] = msg.value;
    }

}


contract Require {

    mapping(address => uint256) accounts;

    function createAccount(uint256 age) public payable {
        require(age >= 18);
        accounts[msg.sender] = msg.value;
    }
    function openAccount(uint256 age) public payable {
        //return with a string error
        require(age >= 18, "age requirement not met");
        accounts[msg.sender] = msg.value;
    }
}


contract Assert {

    address[] accounts;
    uint256 public balance;
    
    function zeroDivision() public payable{
        assert(msg.value / accounts.length > 0);
    }

    function withdraw(uint _amount) public {
        uint oldBalance = balance;
        require(balance >= _amount, "Underflow");
        if(balance < _amount) {
            revert("underflow");
        }
        balance -= _amount;
        assert(balance <= oldBalance);        
    }

    function deposit(uint _amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + _amount;

        require(newBalance >= oldBalance, "Overflow");

        balance =  newBalance;
        assert(balance >= oldBalance);
    }

}