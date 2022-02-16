//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract TokenSwap {
    IERC20 public token1;
    address public owner1;
    uint public amount1;

    IERC20 public token2;
    address public owner2;
    uint public amount2;

    constructor(
        address _token1,
        address _owner1,
        uint _amount1,
        address _token2,
        address _owner2,
        uint _amount2
    )
    {
        token1 = IERC20(_token1);
        owner1 = _owner1;
        amount1 = _amount1;

        token2 = IERC20(_token2);
        owner2 = _owner2;
        amount2 = _amount2;

    }

    modifier onlyOwner() {
        require(msg.sender == owner1 || msg.sender == owner2,
        "not authorized");
        _;
    }

    function swap() public onlyOwner {
        require(token1.allowance(owner1, address(this)) >= amount1, 
        "token1 allowance too low");

        require(token2.allowance(owner2, address(this)) >= amount2,
        "token2 allowance too low");

        _safeTransferFrom(token1, owner1, owner2, amount1);
        _safeTransferFrom(token2, owner2, owner1, amount2);
    }

    function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "token transfer failed");
    }

}

/* testing steps:
    1. deploy DogeCoin contract by owner1
    2. deploy CowCoin contract by owner2
    3. deploy TokenSwap contract by owner1 or owner2
    4. owner1 approve TokenSwap contract for spending X amount of DogeCoin
    5. owner2 approve TokenSwap contract for spending Y amount of CowCoin
    6. call swap function for swapping token
    7. use balanceOf function to check if token has been received by owner1 or owner2
*/
contract DogeCoin is ERC20 {
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply * 10 ** uint(decimals()));
    }
}

contract CowCoin is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1000 * 10 ** uint(decimals()));
    }
}
