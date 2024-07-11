# Types-of-Functions / Create a Mint Token 

This Solidity program introduces a token contract, an ERC20-compliant token designed for the Ethereum blockchain. It offers robust features for token management and governance, including minting, burning, and voter participation in governance through proposal voting.

# Description 

The token contract defines a basic token with key features:

* Owners can mint IC tokens to any address using 'mint'.
* Users can burn their tokens using 'burn'.
* Token holders participate in proposal voting using 'vote', contingent on token ownership.
* Proposal execution ('executeProposal') requires validation by the contract owner."

# Let's Get Started 

To begin this project, set up your Solidity development environment. I recommend using Remix, an online Solidity IDE. Follow these steps:

1. Visit Remix IDE at [Remix](https://remix.ethereum.org).
2. Create a new file: Click the "+" icon in the left sidebar, and save it with a .sol extension. 
3. Copy and paste the provided template code into your new file, if available.

## The Program Execution 

To use Remix with this program:

Copy the code below into your file:

    // SPDX-License-Identifier: MIT
    pragma solidity 0.8.26;
    
    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";

    contract ICToken is ERC20, Ownable {
        // Mapping to track votes by address
        mapping(address => uint256) public votes;
    
        // Mapping to track whether a proposal exists
        mapping(bytes32 => bool) public proposals;
    
        // Constructor to initialize the ERC20 token with name "Token" and symbol "IC"
        constructor() ERC20("Token", "IC") Ownable(msg.sender) {
            // Mint initial supply of tokens (1,000,000 tokens)
            _mint(msg.sender, 1000000 * 10 ** decimals());
        }
    
        // Function to mint new tokens, accessible only by the owner
        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }
    
        // Function to burn tokens
        function burn(uint256 amount) public {
            _burn(msg.sender, amount);
        }
    
        // Function for an address to vote on a proposal
        function vote(bytes32 proposal) external {
            // Require that the sender has tokens to vote
            require(balanceOf(msg.sender) > 0, "Must have tokens to vote");
    
            // Accumulate voting power based on token balance
            votes[msg.sender] += balanceOf(msg.sender);
    
            // Record the proposal as active
            proposals[proposal] = true;
        }
    
        // Function to execute a proposal, accessible only by the owner
        function executeProposal(bytes32 proposal) external onlyOwner {
            // Require that the proposal exists and has not been executed yet
            require(proposals[proposal], "Proposal does not exist or already executed");
    
            // Mark the proposal as executed (inactive)
            proposals[proposal] = false;
        }
    }

## Deploying and Interacting with the IC Token Smart Contract

Compile the Code:
* Navigate to the "Solidity Compiler" tab on the left-hand sidebar.
* Ensure the compiler version is set to "0.8.26" or another compatible version.
* Click on "Compile ICToken.sol" to compile the contract.

Deploy the Contract:
* Switch to the "Deploy & Run Transactions" tab.
* Choose the "ICToken" contract from the dropdown menu.
* Click on "Deploy" and provide necessary constructor parameters if required.

Interact with the Contract:
   - Once deployed, you can perform the following actions:

Mint: Create new IC tokens.
Burn: Destroy IC tokens.
Vote: Cast a vote on a proposal.
Execute Proposal: Implement a validated proposal.
Transfer: Send IC tokens to another address.
Transfer From: Move IC tokens from one address to another.
Approve: Authorize a spender to manage IC tokens on your behalf.
Balance Of: Check the IC token balance of any address.
Allowance: Verify the amount of IC tokens a spender can access on behalf of the owner.
Total Supply: View the total supply of IC tokens.
Name: Retrieve the name of the IC token.
Votes: Access the total votes held by a specific address.
Proposals: Verify the status of a proposal.

This sequence outlines how to compile, deploy, and interact with the IC Token smart contract using the Remix IDE or a similar Solidity development environment.


# Authors
Metacrafter Student Ivanne Cres Yabut
https://x.com/ivanne_cres

# License
This project is licensed under the author's License - see the LICENSE.md file for details
