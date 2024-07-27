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

    // Function for transfer 
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
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
