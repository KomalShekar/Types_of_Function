// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MysticToken is ERC20, Ownable {
    constructor(string memory tokenName, string memory tokenSymbol, uint256 initialSupply) ERC20(tokenName, tokenSymbol) Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    // Function to mint tokens, only the contract owner can mint tokens
    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    // Function to transfer tokens, anyone can transfer tokens to a different account
    function transferTokens(address recipient, uint256 amount) public returns (bool) {
        require(amount > 0, "MysticToken: Token transfer amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "MysticToken: Low balance");

        _transfer(msg.sender, recipient, amount);
        return true;
    }

    // Function to burn tokens, any user can burn tokens
    function burnTokens(uint256 amount) public returns (bool) {
        require(amount > 0, "MysticToken: Burn amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "MysticToken: Low balance");

        _burn(msg.sender, amount);
        return true;
    }
}
