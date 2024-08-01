// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract VelnerableBank {
    mapping(address=>uint256) public balances;

    function deposit() external payable {
        require(msg.value >= 0, "invalid amount");
        balances[msg.sender] +=msg.value;
    }

    function withdraw(uint256 amount_) public {
        require(amount_ >= 0, "invalid amount");
        require(balances[msg.sender] > 0,"insufficient balance");
        balances[msg.sender] -= amount_;
    

        // The problematic line: sending ether before updating the balance
       (bool success,) = msg.sender.call{value:amount_} (" ");
       require(success, "transfer failed");

       // update the balance after sending
       balances[msg.sender] -= amount_;
    }

    function getBalance() view public returns(uint256) {
        return balances[msg.sender];
    }
}