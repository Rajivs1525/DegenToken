// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    event Redeemed(address indexed account, uint256 indexed tokenId, string message);

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function redeem(uint256 tokenId) external {
        uint256 requiredTokens;

        string memory redemptionMessage;

        if (tokenId == 1) {
            requiredTokens = 1000;
            redemptionMessage = "Unlocked a new skin in the game!";
        } else if (tokenId == 2) {
            requiredTokens = 200;
            redemptionMessage = "Received a special item!";
        } else if (tokenId == 3) {
            requiredTokens = 3000;
            redemptionMessage = "Gained access to an exclusive feature!";
        } else {
            revert("Invalid tokenId");
        }

        require(balanceOf(msg.sender) >= requiredTokens, "Insufficient tokens");

        _burn(msg.sender, requiredTokens);

        emit Redeemed(msg.sender, tokenId, redemptionMessage);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
