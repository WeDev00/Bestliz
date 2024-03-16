//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// Import smart contract for staking
import "./Chat.sol";

/**
 * @title Factory contract for the creation of staking contracts
 * @author WeDev00
 * @notice This contract allows new staking contracts to be created for several ERC-20 tokens
 * @dev The contract uses smart contract staking to create new contracts
 */
contract StakingFactory {

    // Owner's address
    address public owner;

    //stores deployed chats
    address[] deployedContract;

    // Event issued when a new staking contract is created
    event StakingContractCreated(IERC20[2] indexed tokens, address stakingContract);

    /**
     * @dev Contract's constructor
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Function to create a new staking contract
     * @param homeTeamFanToken Address of the ERC-20 token home club to be staked
     * @param guestTeamFanToken Address of the ERC-20 token guest club to be staked
     * @param _stakingTime Staking duration in seconds
     * @return _stakingContract Address of the new staking contract
     */
    function createStakingContract(
        address homeTeamFanToken,
        address guestTeamFanToken,
        string memory eventName,
        uint256 _stakingTime
    ) external onlyOwner returns (address _stakingContract) {
         IERC20[2] memory tokenToStake=[IERC20(homeTeamFanToken),IERC20(guestTeamFanToken)];
        // Create a new staking contract
        ChatStaking stakingContract = new ChatStaking(owner,eventName,tokenToStake, _stakingTime);

        // Store the address of the new staking contract
        deployedContract.push(address(stakingContract));

        // Issue an event to notify the creation of the new contract
        emit StakingContractCreated(tokenToStake,address(stakingContract));

        return address(stakingContract);
    }

    /**
     * @notice Function to change the owner of the contract
     * @param _newOwner New owner's address
     */
    function changeOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Error: new owner isn't valid");

        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Errore: solo il proprietario puo' eseguire questa funzione");
        _;
    }

}
