//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// Importa lo standard ERC-20
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "std/Std.sol";
/**
 * @title Smart contract for staking ERC-20 tokens
 * @author WeDev00
 * @notice This contract allows users to stake existing ERC-20 tokens
 */
contract ChatStaking {
    
    struct StakedTokens{
        uint256 amount;
        address tokenAddress;
    }

    //owner of this contract
    address private owner;

    //name of the event
    string public name;

    // ERC-20 token addresses to be staked
    IERC20[] public tokens;

    uint256 public amountToStake;

    // Staking duration in seconds
    uint256 public stakingDuration;

    // Mapping that stores the amount in staking for each user
    mapping(address => StakedTokens) public staked;

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
        address _owner,
        string memory _name,
         IERC20[2]  memory _tokens,
        uint256 _stakingDuration
    ) {
        owner=_owner;
        tokens = _tokens;
        stakingDuration = _stakingDuration;
        name=_name;
    }


    
    function getName() public view returns (string memory){
        return name;
    }

    function setName(string memory _name) public onlyOwner {
        name=_name;
    }

    // ERC-20 token addresses to be staked
   /* IERC20[] public tokens;

    function getTokens() public returns (memory IERC20[]){}

    uint256 public amountToStake;

    // Staking duration in seconds
    uint256 public stakingDuration;

    // Mapping that stores the amount in staking for each user
    mapping(address => StakedTokens) public staked;

    // Mapping that stores the staking start timestamp for each user
    mapping(address => uint256) public startTime;
*/


    /**
     * @notice Function for staking tokens
     * @param _amount Amount of tokens to be staked
     * @param isHomeTeamToken Boolean indicating whether the tokens to be staked are of home team or guest team
     */
    function stake(uint256 _amount,bool isHomeTeamToken) external {
        require(_amount >= amountToStake, "Errore: importo non valido");
        
        
        // Transfer the tokens from the user's wallet to the contract
        if(isHomeTeamToken){
        tokens[0].transferFrom(msg.sender, address(this), _amount);
        staked[msg.sender].tokenAddress=address(tokens[0]);
        }
        else {
            tokens[1].transferFrom(msg.sender,address(this),_amount);
            staked[msg.sender].tokenAddress=address(tokens[1]);
        }

        // Updates the user's staking status
        staked[msg.sender].amount += _amount;
        startTime[msg.sender] = block.timestamp;

        emit Staked(msg.sender, _amount);
    }


    /**
     * @notice Function for staking tokens
     * @return boolean indicating whether the user has staked the correct amount of tokens
     */
    function isAllowed() public view returns(bool){
        require(staked[msg.sender].amount!=0,"Error:sender never staked some tokens");
        return staked[msg.sender].amount >= amountToStake;
    }


    /**
     * @notice Function for withdrawing tokens
     */
    function unstake() external {
        require(block.timestamp >= startTime[msg.sender] + stakingDuration, "Errore: periodo di staking non ancora terminato");

        // Unstake your tokens
        if(IERC20(staked[msg.sender].tokenAddress)==tokens[0])
        tokens[0].transfer(msg.sender, staked[msg.sender].amount );
        else{
            tokens[1].transfer(msg.sender, staked[msg.sender].amount );
        }

        // Updates the user's staking status
        staked[msg.sender].amount = 0;
        startTime[msg.sender] = 0;

        emit Unstaked(msg.sender, staked[msg.sender].amount);
    }

    /**
     * @notice Function for users slashing in case of disrespectuf behavior
     * @param userToSlash address of user to slash
     */
    function slashUser(address userToSlash) public onlyOwner{
        IERC20(staked[userToSlash].tokenAddress).transfer(owner,staked[userToSlash].amount);
        staked[userToSlash].amount=0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Errore: solo il proprietario puo' eseguire questa funzione");
        _;
    }

}