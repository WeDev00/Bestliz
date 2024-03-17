// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RealACMilan is ERC20, Ownable {
	constructor() ERC20("Real AC Milan", "rMILAN") Ownable(msg.sender) {
		_mint(msg.sender, 100 * 10 ** decimals());
	}

	function mint(address to, uint256 amount) public onlyOwner {
		_mint(to, amount);
	}
}
