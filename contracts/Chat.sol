//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// Importa lo standard ERC-20
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title Smart contract for staking ERC-20 tokens
 * @author WeDev00
 * @notice This contract allows users to stake existing ERC-20 tokens
 */
contract ChatStaking {

    string name;

    // ERC-20 token addresses to be staked
    IERC20[] public tokens;

    uint256 amountToStake;

    // Staking duration in seconds
    uint256 public stakingDuration;

    // Mapping that stores the amount in staking for each user
    mapping(address => uint256) public staked;

    // Mapping that stores the staking start timestamp for each user
    mapping(address => uint256) public startTime;

    // Event emitted when a user stakes tokens
    event Staked(address indexed user, uint256 amount);

    // Event issued when a user withdraws tokens
    event Unstaked(address indexed user, uint256 amount);

    /**
     * @dev Contract's constructor
     * @param _tokens ERC-20 token addresses to be staked
     * @param _stakingDuration Staking duration in seconds
     */
    constructor(
        string memory _name,
         IERC20[2]  memory _tokens,
        uint256 _stakingDuration
    ) {
        tokens = _tokens;
        stakingDuration = _stakingDuration;
        name=_name;
    }

    /**
     * @notice Function for staking tokens
     * @param _amount Amount of tokens to be staked
     * @param isHomeTeamToken Boolean indicating whether the tokens to be staked are of home team or guest team
     */
    function stake(uint256 _amount,bool isHomeTeamToken) external {
        require(_amount >= amountToStake, "Errore: importo non valido");
        
        
        // Trasferisci i token dal wallet dell'utente al contratto
        if(isHomeTeamToken)
        tokens[0].transferFrom(msg.sender, address(this), _amount);
        else {
            tokens[1].transferFrom(msg.sender,address(this),_amount);
        }

        // Aggiorna lo stato di staking dell'utente
        staked[msg.sender] += _amount;
        startTime[msg.sender] = block.timestamp;

        emit Staked(msg.sender, _amount);
    }


    /**
     * @notice Function for staking tokens
     * @return boolean indicating whether the user has staked the correct amount of tokens
     */
    function isAllowed() public view returns(bool){
        return staked[msg.sender] >= amountToStake;
    }

    /**
     * @notice Funzione per ritirare i token
     * @param isHomeTeamToken Boolean indicating whether the tokens to be staked are of home team or guest team
     */
    function unstake(bool isHomeTeamToken) external {
        require(block.timestamp >= startTime[msg.sender] + stakingDuration, "Errore: periodo di staking non ancora terminato");

        // Unstake your tokens
        if(isHomeTeamToken)
        tokens[0].transfer(msg.sender, staked[msg.sender] );
        else{
            tokens[1].transfer(msg.sender, staked[msg.sender] );
        }

        // Aggiorna lo stato di staking dell'utente
        staked[msg.sender] = 0;
        startTime[msg.sender] = 0;

        emit Unstaked(msg.sender, staked[msg.sender]);
    }
}
