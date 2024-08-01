# How Hacker can steal your money by using Reentrancy Attack

The Attacker contract is specifically crafted to exploit a reentrancy vulnerability in the VelnerableBank contract. Here’s a detailed breakdown of how the attack works:

# Components and Setup:
@ Vulnerable Contract Reference:

The Attacker contract holds a reference to the VelnerableBank contract, stored in the vulnerable variable. This reference is provided during the deployment of the Attacker contract via the constructor.
# Owner:

The contract has an owner state variable set to the address that deployed the contract. Only the owner can withdraw funds from the Attacker contract.
# Attack Mechanism:
# Attack Initiation:

The attack function is called by the attacker and requires a small Ether deposit (at least 1 wei). This function deposits the Ether into the VelnerableBank contract by calling its deposit function with 1 wei.

# Reentrancy Exploit:

After the initial deposit, the Attacker contract immediately calls the withdraw function of the VelnerableBank to withdraw the same amount (1 wei).
When VelnerableBank sends back the 1 wei, the receive function in the Attacker contract is triggered.

# Receive Function Execution:

Inside the receive function, a check is performed to see if the VelnerableBank still has a balance greater than 1 wei. If so, it calls vulnerable.withdraw(1 wei) again.
This leads to a recursive loop: every time the receive function is triggered, it attempts to withdraw another 1 wei from the VelnerableBank, before the previous withdrawal can finalize.

# Drainage of Funds:

The recursive loop continues, rapidly draining the VelnerableBank contract's balance, as the state changes in VelnerableBank (such as updating balances or setting flags) do not get a chance to be executed before the next withdrawal attempt.

# Post-Attack:
# Withdrawal of Stolen Funds:

Once the VelnerableBank contract is drained or the attacker decides to stop the attack, they can call the withdraw function in the Attacker contract. This function allows only the owner (attacker) to transfer the stolen Ether from the Attacker contract to their own address.

# The vulnerability exploited here is due to the lack of updating state before making external calls in the VelnerableBank contract. Specifically, it fails to update the user's balance or set a flag indicating that a withdrawal is in process before transferring funds, allowing the attacker to repeatedly call the withdrawal function.
