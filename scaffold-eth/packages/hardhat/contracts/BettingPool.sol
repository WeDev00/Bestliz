//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

/**
 * @title  BettingPool contract to allow users to bet
 * @author WeDev00
 */
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./FidelityToken.sol";
contract BettingPool{

    struct Better {
        address wallet;
        uint256 betChiliz;
    }

    struct Reward{
        uint256 fidelityTokensPerDay;
        uint256 timestamp;
    }

    address owner;

    address deployedFidelityToken;

    mapping(address=>Reward) rewardedBetter;

    mapping(address=>bool) rewardedAddress;

	//Address of the chat to which this BettingPool refers
	address chatAddress;

	//Variable for creating a bet id
	uint256 betIds;

	//Address of a Lending platform
	address lendingPlatformAddress;

	//Map to store a short description of a bet;
	mapping(uint256 => string) descriptions;

	//Map for placers storage
	mapping(uint256 => Better[]) placers;

	//Map for joiners storage
	mapping(uint256 => Better[]) joiners;


    constructor(address _owner,address _chatAddress,address _lendingPlatformAddress,address fidelityTokenAddress){
        owner=_owner;
        chatAddress=_chatAddress;
        betIds=0;
        lendingPlatformAddress=_lendingPlatformAddress;
        deployedFidelityToken=fidelityTokenAddress;
    }

	function getChatAddress() public view returns (address) {
		return chatAddress;
	}

	function getNumberOfPlacedBet() public view returns (uint256) {
		return betIds;
	}

	function getDescriptions() public view returns (string[] memory) {
		string[] memory descriptionsToReturn = new string[](betIds);
		for (uint256 i = 1; i <= betIds; i++)
			descriptionsToReturn[i - 1] = descriptions[i];
		return descriptionsToReturn;
	}

	function getDescriptionByBetId(
		uint256 betId
	) public view returns (string memory) {
		return descriptions[betId];
	}

    function placeANewBet(string memory description) payable public {
        betIds+=1;
        descriptions[betIds]=description;
        placers[betIds][betIds-1]=Better(msg.sender,msg.value-msg.value/100);
    }

    function placeExistingBet(uint256 existingId) payable public {
        placers[existingId][placers[existingId].length-1]=Better(msg.sender,msg.value);
    }

	function joinABet(uint256 betId) public payable {
		uint256 numbersOfJoiner = joiners[betId].length;
		joiners[betId][numbersOfJoiner - 1] = Better(msg.sender, msg.value);
	}

    function onWin(uint256 betId,bool placersWins) public onlyOwner{

        //Immediate return of wagered tokens
        if(placersWins){
            for(uint256 i=0;i<placers[betId].length;i++){
                sendNativeTokens(placers[betId][i].wallet,placers[betId][i].betChiliz);
                rewardedBetter[placers[betId][i].wallet]=Reward(placers[betId][i].betChiliz/5,block.timestamp);
                rewardedAddress[placers[betId][i].wallet]=true;
            }
        }
        else{
            for(uint256 i=0;i<joiners[betId].length;i++){
                sendNativeTokens(joiners[betId][i].wallet,joiners[betId][i].betChiliz);
                rewardedBetter[joiners[betId][i].wallet]=Reward(joiners[betId][i].betChiliz/5,block.timestamp);
                rewardedAddress[joiners[betId][i].wallet]=true;
            }
        }
    }

    function withdrawRewards() public onlyRewarded{
        //you can take your reward after 5 days
        require(block.timestamp>=rewardedBetter[msg.sender].timestamp+432.000);
        FidelityToken ourToken=FidelityToken(deployedFidelityToken);
        ourToken.mint(msg.sender,rewardedBetter[msg.sender].fidelityTokensPerDay*5);
    }

	function sendNativeTokens(address _to, uint256 _amount) internal {
		// Sending $CHZ to the specified address
		(bool success, ) = _to.call{ value: _amount }("");
		require(success, "Transaction failed");
	}

    modifier onlyOwner() {
        require(msg.sender == owner, "Error: only the owner can perform this function");
        _;
    }

    modifier onlyRewarded(){
        require(rewardedAddress[msg.sender]!=false,"You cannot claim reward that you didn't win");
        _;
    }

}
