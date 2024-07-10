# Types-of-Functions / Create a Mint Token 

This Solidity program introduces a token contract, an ERC20-compliant token designed for the Ethereum blockchain. It offers robust features for token management and governance, including minting, burning, and voter participation in governance through proposal voting.

# Description 

The token contract defines a basic token with key features:

* Owners can mint VINCE tokens to any address using 'mint'.
* Users can burn their tokens using 'burn'.
* Token holders participate in proposal voting using 'vote', contingent on token ownership.
* Proposal execution ('executeProposal') requires validation by the contract owner."

# Let's Get Started 

To begin this project, set up your Solidity development environment. I recommend using Remix, an online Solidity IDE. Follow these steps:

1. Visit Remix IDE at [Remix](https://remix.ethereum.org).
2. Create a new file: Click the "+" icon in the left sidebar, and save it with a .sol extension (e.g., VinceToken.sol).
3. Copy and paste the provided template code into your new file, if available.

## The Program Execution 

To use Remix with this program:

Copy the code below into your file:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    // Mapping to track the number of votes each address has
    mapping(address => uint256) public votes;
    
    // Mapping to track whether a proposal has been made
    mapping(bytes32 => bool) public proposals;

    // Constructor to initialize the ERC20 token with name "Token" and symbol "IC"
    constructor() ERC20("Token", "ic") {
        // Mint initial supply of tokens to the contract deployer
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Function to mint new tokens, accessible only by the contract owner
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens, accessible by any token holder
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Function for a token holder to vote on a proposal
    function vote(bytes32 proposal) external {
        // Require the sender to have tokens to vote
        require(balanceOf(msg.sender) > 0, "Must have tokens to vote");
        
        // Increase the number of votes the sender has by their token balance
        votes[msg.sender] += balanceOf(msg.sender);
        
        // Mark the proposal as true (exists)
        proposals[proposal] = true;
    }

    // Function for the contract owner to execute a proposal
    function executeProposal(bytes32 proposal) external onlyOwner {
        // Require the proposal to exist and not have been executed already
        require(proposals[proposal], "Proposal does not exist or already executed");
        
        // Mark the proposal as executed (false)
        proposals[proposal] = false; 
    }
}

# Authors


# License
This project is licensed under the author's License - see the LICENSE.md file for details
