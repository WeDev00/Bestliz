//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FidelityToken is ERC20 {
  address[] public owners;

  constructor(uint256 initialSupply ) ERC20("Bestliz Fidelity Token", "BFT") {
    _mint(msg.sender, initialSupply);
    owners.push(msg.sender);
  }

  function _transfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override onlyOwners{
    super._transfer(from, to, amount);
  }


  function mint(address recipient,uint256 amount) public onlyOwners{
    _mint(recipient,amount);
  }

  function addOwner(address newOwner) public onlyOwners{
    owners.push(newOwner);
  }

  modifier onlyOwners() {
  require(isOwner(msg.sender), "Access denied: only owners perform this operation");
  _;
}

function isOwner(address addr) private view returns (bool) {
  for (uint256 i = 0; i < owners.length; i++) {
    if (owners[i] == addr) {
      return true;
    }
  }
  return false;
}

}
