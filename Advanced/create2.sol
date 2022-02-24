//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract DeploymentFactory {
    event Deployed(address addr, uint salt);

    //the constructor arguments of the target contract to be passed in
    function getContractByteCode(
        string memory _name, 
        string memory _symbol, 
        uint256 _initialSupply) 
        public pure returns (bytes memory)
    {
        bytes memory bytecode = type(DogeCoin).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_name, _symbol, _initialSupply));
    }

    //_salt is an arbitrary value provided by the sender
    function computeContractAddress(bytes memory bytecode, uint256 _salt) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        //cast last 20 bytes of hash to address
        return address(uint160(uint256(hash)));
    }

    function deploy(bytes memory bytecode, uint256 _salt) public payable {
        address addr;

        /*
        How to call create2

        create2(v, p, n, s)
        create new contract with code at memory p to p + n
        and send v wei
        and return the new address
        where new address = first 20 bytes of keccak256(0xff + address(this) + s + keccak256(mem[p…(p+n)))
              s = big-endian 256-bit value
        */

        assembly {
            addr := create2(
                //wei sent with current function call
                callvalue(), 
                //skipping first 32 bytes to the actual code
                add(bytecode, 0x20),
                //load the size of code contained from the first 32 bytes
                mload(bytecode),
                //the random number from function call
                _salt
            )

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        emit Deployed(addr, _salt);
    }
}

//contract to be deployed
contract DogeCoin is ERC20 {
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply * 10 ** uint(decimals()));
    }
}
