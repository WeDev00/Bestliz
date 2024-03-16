//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

/**
 * @title  BettingPool contract to allow users to bet
 * @author WeDev00
 */

contract BettingPool{

    struct Better {
        address wallet;
        uint256 betChiliz;
    }

    address owner;

    //Address of the chat to which this BettingPool refers
    address chatAddress;

    //Variable for creating a bet id
    uint256 betIds;

    //Address of a Lending platform
    address lendingPlatformAddress;

    //Map to store a short description of a bet;
    mapping(uint256=>string) descriptions;

    //Map for placers storage
    mapping(uint256=>Better[]) placers;

    //Map for joiners storage
    mapping(uint256=>Better[]) joiners;


    constructor(address _owner,address _chatAddress,address _lendingPlatformAddress){
        owner=_owner;
        chatAddress=_chatAddress;
        betIds=0;
        lendingPlatformAddress=_lendingPlatformAddress;
    }

    function placeABet(string memory description) payable public {
        betIds+=1;
        descriptions[betIds]=description;
        placers[betIds][betIds-1]=Better(msg.sender,msg.value);
    }

    function joinABet(uint256 betId) payable public {
        uint256 numbersOfJoiner=joiners[betId].length;
        joiners[betId][numbersOfJoiner-1]=Better(msg.sender,msg.value);
    }

    function onWin(uint256 betId,bool placersWins) public onlyOwner{

        //Immediate return of wagered tokens
        if(placersWins){
            for(uint256 i=0;i<placers[betId].length;i++)
                sendNativeTokens(placers[betId][i].wallet,placers[betId][i].betChiliz);
        }
        else{
            for(uint256 i=0;i<joiners[betId].length;i++)
                sendNativeTokens(joiners[betId][i].wallet,joiners[betId][i].betChiliz);
        }

        //TO-DO: implement fidelity token reward
    }

    function sendNativeTokens(address _to, uint256 _amount) internal{
  // Sending $CHZ to the specified address
  (bool success, ) = _to.call{value: _amount}("");
  require(success, "Invio fallito");
  }

    modifier onlyOwner() {
        require(msg.sender == owner, "Errore: solo il proprietario puo' eseguire questa funzione");
        _;
    }

}