// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RealManchesterCity is ERC20, Ownable {
	constructor() ERC20("Real Manchester City", "rCITY") Ownable(msg.sender) {
		_mint(msg.sender, 100 * 10 ** decimals());
	}

	function mint(address to, uint256 amount) public onlyOwner {
		_mint(to, amount);
	}
}
