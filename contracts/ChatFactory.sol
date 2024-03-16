//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// Importa lo smart contract per lo staking
import "./Chat.sol";

/**
 * @title Contratto Factory per la creazione di contratti di staking
 * @author WeDev00
 * @notice Questo contratto consente di creare nuovi contratti di staking per diversi token ERC-20
 * @dev Il contratto utilizza lo smart contract Staking per creare nuovi contratti
 */
contract StakingFactory {

    // Indirizzo del proprietario del contratto
    address public owner;

    uint256 stakingTime;

    address[] deployedContract;
    // Evento emesso quando viene creato un nuovo contratto di staking
    event StakingContractCreated(IERC20[2] indexed tokens, address stakingContract);

    /**
     * @dev Costruttore del contratto
     */
    constructor(uint256 _stakingTime) {
        owner = msg.sender;
        stakingTime=_stakingTime;
    }

    /**
     * @notice Funzione per creare un nuovo contratto di staking
     * @param homeTeamFanToken Indirizzo del token ERC-20 del football club che gioca in casa da mettere in stake
     * @param guestTeamFanToken Indirizzo del token ERC-20 del football club che gioca fuori casa da mettere in stake
     * @param _stakingTime Durata dello staking in secondi
     * @return _stakingContract Indirizzo del nuovo contratto di staking
     */
    function createStakingContract(
        address homeTeamFanToken,
        address guestTeamFanToken,
        uint256 _stakingTime
    ) external onlyOwner returns (address _stakingContract) {
         IERC20[2] memory tokenToStake=[IERC20(homeTeamFanToken),IERC20(guestTeamFanToken)];
        // Crea un nuovo contratto di staking
        ChatStaking stakingContract = new ChatStaking(tokenToStake, _stakingTime);

        // Memorizza l'indirizzo del nuovo contratto di staking
        deployedContract.push(address(stakingContract));

        // Emetti un evento per notificare la creazione del nuovo contratto
        emit StakingContractCreated(tokenToStake,address(stakingContract));

        return address(stakingContract);
    }

    /**
     * @notice Funzione per modificare il proprietario del contratto
     * @param _newOwner Indirizzo del nuovo proprietario
     */
    function changeOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Errore: nuovo proprietario non valido");

        owner = _newOwner;
    }

    /**
     * @dev Funzione di modifica per il proprietario del contratto
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Errore: solo il proprietario puo' eseguire questa funzione");
        _;
    }

}
