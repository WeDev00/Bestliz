//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

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

    // Mapping that stores if a user exist in our staked mapping
    mapping(address=>bool) public haveStaked;

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

    function getTokens() public view returns (IERC20[] memory){
        return tokens;
    }

    function setTokens(IERC20[] memory _tokens) public onlyOwner{
        tokens=_tokens;
    }

    function setHomeToken(address _homeTeamAddress) public onlyOwner{
        tokens[0]=IERC20(_homeTeamAddress);
    }

    function setGuestToken(address _guestTeamAddress) public onlyOwner{
        tokens[1]=IERC20(_guestTeamAddress);
    }

    function getAmountToStake() public view returns(uint256){
        return amountToStake;
    }

    function modifyAmountToStake(uint256 newAmount) public onlyOwner{
        amountToStake=newAmount;
    }

    function getStakingDuration() public view returns(uint256){
        return stakingDuration;
    }

    function modifyStakingDuration(uint256 newDuration) public onlyOwner{
        stakingDuration=newDuration;
    }


    function getAmountOfTokensStakedByAddress(address user) public view returns(StakedTokens memory){
        return staked[user];
    }


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
        if(haveStaked[msg.sender]==true)
        staked[msg.sender].amount += _amount;
        else{
        staked[msg.sender].amount=_amount;
        haveStaked[msg.sender]=true;
        }
        startTime[msg.sender] = block.timestamp;

        emit Staked(msg.sender, _amount);
    }


    /**
     * @notice Function for staking tokens
     * @return boolean indicating whether the user has staked the correct amount of tokens
     */
    function isAllowed() public view returns(bool){
        return staked[msg.sender].amount >= amountToStake;
    }


    /**
     * @notice Function for withdrawing tokens
     */
    function unstake() external {
        require(block.timestamp >= startTime[msg.sender] + stakingDuration, "Errore: periodo di staking non ancora terminato");
        require(haveStaked[msg.sender],"Error:sender never staked some tokens");
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
