//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "./BettingPool.sol";
import "./FidelityToken.sol";
/**
 * @title Factory contract for the creation of BettingPool contracts
 * @author WeDev00
 * @notice This contract allows new BettingPool contracts to be created for several ERC-20 tokens
 */

contract BettingPoolFactory {
	address owner;

	//stores deployed chats
	address[] deployedContract;

    address deployedFidelityTokenAddress;
    //stores deployed chats
    address[] deployedContract;

	constructor() {
		owner = msg.sender;
	}

	/**
	 * @notice Function to create a BettingPool contract
	 * @param _chatAddress Chat address for this betting pool
	 * @param _lendingPlatformAddress Address of the lending pool we will use to lend the $CHZ of the losing bets
	 * @return bettingPool Address of the new betting pool
	 */
	function createBettingPool(
		address _chatAddress,
		address _lendingPlatformAddress
	) external onlyOwner returns (address) {
		BettingPool bettingPool = new BettingPool(
			owner,
			_chatAddress,
			_lendingPlatformAddress
		);
		deployedContract.push(address(bettingPool));
		emit BettingPoolCreated(_chatAddress, address(bettingPool));
		return address(bettingPool);
	}

    /**
     * @notice Function to create a BettingPool contract
     * @param _chatAddress Chat address for this betting pool
     * @param _lendingPlatformAddress Address of the lending pool we will use to lend the $CHZ of the losing bets
     * @return bettingPool Address of the new betting pool
     */
    function createBettingPool(address _chatAddress,address _lendingPlatformAddress) external  onlyOwner returns (address){
        FidelityToken ourToken=FidelityToken(deployedFidelityTokenAddress);
        BettingPool bettingPool=new BettingPool(owner,_chatAddress,_lendingPlatformAddress,deployedFidelityTokenAddress);
        deployedContract.push(address(bettingPool));
        ourToken.addOwner(address(bettingPool));
        emit BettingPoolCreated(_chatAddress,address(bettingPool));
        return address(bettingPool);
    }

		owner = _newOwner;
	}

	modifier onlyOwner() {
		require(
			msg.sender == owner,
			"Errore: solo il proprietario puo' eseguire questa funzione"
		);
		_;
	}
}
