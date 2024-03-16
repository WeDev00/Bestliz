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

    //Address of the chat to which this BettingPool refers
    address chatAddress;

    //Variable for creating a bet id
    uint256 betIds;

    //Variabile per memorizzare il tempo addizionale da dare per il ritiro dei token
    uint256 onLossAdditionalTime;

    //Map to store a short description of a bet;
    mapping(uint256=>string) descriptions;

    //Map for placers storage
    mapping(uint256=>Better[]) placers;

    //Map for joiners storage
    mapping(uint256=>Better[]) joiners;


    constructor(address _chatAddress){
        chatAddress=_chatAddress;
        betIds=0;
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

    function onWin(bool placersWins) public {

    }


    

}